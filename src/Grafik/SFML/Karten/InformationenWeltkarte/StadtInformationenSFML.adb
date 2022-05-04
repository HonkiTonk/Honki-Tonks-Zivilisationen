pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with StadtKonstanten;
with KartenVerbesserungDatentypen;
with TextKonstanten;

with LeseStadtGebaut;

with GesamtwerteFeld;
with KampfwerteStadtErmitteln;
with DebugPlatzhalter;
with GrafikEinstellungenSFML;
with Fehler;

package body StadtInformationenSFML is

   function Stadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AnzeigeAnfangenExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      TextPosition := AnzeigeAnfangenExtern;
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      case
        SchriftartFestgelegt
      is
         when False =>
            SchriftartFestgelegt := SchriftartFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftgrößeFestgelegt
      is
         when False =>
            SchriftgrößeFestgelegt := SchriftgrößenFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftfarbeFestgelegt
      is
         when False =>
            SchriftfarbeFestgelegt := SchriftfarbenFestlegen;
            
         when True =>
            null;
      end case;
      
      -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist und sich dort eine Stadt befindet.
      StadtartName (RasseExtern            => RasseExtern,
                    StadtRasseNummerExtern => StadtRasseNummerExtern);
      Einwohner (StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtRasseNummerExtern.Rasse = RasseExtern
        or
          DebugPlatzhalter.FeindlicheInformationenSehen
      then
         AktuelleNahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuelleNahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
                                 
         AktuelleProduktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuelleGeldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuelleForschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern);
                  
         AktuelleVerteidigung (StadtRasseNummerExtern => StadtRasseNummerExtern);
         AktuellerAngriff (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
         Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern);
         EinwohnerOhneArbeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
                        
         AktuellesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);

      else
         null;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextAccess (TextSchleifenwert));
         
      end loop TextSchleife;
      
      return TextPosition;
      
   end Stadt;
   
   

   procedure StadtartName
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      -- Diese Anzeige komplett in die Kartenanzeige verschieben? 
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "StadtInformationenSFML.StadtartName - Stadt sollte existieren tut sie aber nicht.");
            
         when KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 1;

            else
               Stadtart := 3;
            end if;
            
         when KartenVerbesserungDatentypen.Eigene_Stadt_Enum =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 2;
               
            else
               Stadtart := 4;
            end if;
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (1),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (Stadtart)) & " " & StadtName (StadtRasseNummerExtern => StadtRasseNummerExtern));
      Sf.Graphics.Text.setPosition (text     => TextAccess (1),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (1)).height;
      
   end StadtartName;
   
   
   
   function StadtName
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
   end StadtName;
   
   
   
   procedure Einwohner
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                            EinwohnerArbeiterExtern => True));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (2),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugEinwohner)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (2),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (2)).height;
      
   end Einwohner;
   
   
   
   procedure AktuelleNahrungsmittel
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (3),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugNahrungsmittel)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (3),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (3)).height;
      
   end AktuelleNahrungsmittel;
   
   
   
   procedure AktuelleNahrungsproduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (4),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugNahrungsproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (4),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (4)).height;
      
   end AktuelleNahrungsproduktion;
   
   
   
   procedure AktuelleProduktionrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (5),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugRessourcenproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (5),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (5)).height;
      
   end AktuelleProduktionrate;
   
   
   
   procedure AktuelleGeldgewinnung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (6),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGeldproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (6),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (6)).height;
      
   end AktuelleGeldgewinnung;
   
   
   
   procedure AktuelleForschungsrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (7),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugWissensproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (7),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (7)).height;
      
   end AktuelleForschungsrate;
   
   
   
   procedure AktuelleVerteidigung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (8),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerteidigung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (8),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (8)).height;
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (9),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAngriff)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (9),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (9)).height;
      
   end AktuellerAngriff;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (10),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugKorruption)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (10),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (10)).height;
      
   end Korruption;
   
   
   
   procedure EinwohnerOhneArbeit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                            EinwohnerArbeiterExtern => True)
                                                           - LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                EinwohnerArbeiterExtern => False));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (11),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerfügbareArbeiter)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (11),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (11)).height;
      
   end EinwohnerOhneArbeit;
   
   
   
   procedure AktuellesBauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer = StadtKonstanten.LeerBauprojekt.Nummer
      then
         Text := GlobaleTexte.Zeug (28);
            
      elsif
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).GebäudeEinheit = True
      then
         Text := GlobaleTexte.Gebäude (2 * Natural (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer) - 1);

      else
         Text := GlobaleTexte.Einheiten (2 * Natural (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer) - 1);
      end if;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (12),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugBauprojekt)) & " " & To_Wide_Wide_String (Source => Text));
      Sf.Graphics.Text.setPosition (text     => TextAccess (12),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (12)).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (13),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerbleibendeBauzeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (13),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (13)).height;
      
   end AktuellesBauprojekt;
   
   
   
   procedure EinzelnesFeldNahrungsgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                                                                      RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (14),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugNahrungsgewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (14),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (14)).height;
      
   end EinzelnesFeldNahrungsgewinnung;
   
   
   
   procedure EinzelnesFeldRessourcengewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                                                         RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (15),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugRessourcengewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (15),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (15)).height;
      
   end EinzelnesFeldRessourcengewinnung;
   
   
   
   procedure EinzelnesFeldGeldgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                                                                   RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (16),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGeldgewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (16),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (16)).height;
      
   end EinzelnesFeldGeldgewinnung;
   
   
   
   procedure EinzelnesFeldWissensgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                                                                     RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (17),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugWissensgewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess (17),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (17)).height;
      
   end EinzelnesFeldWissensgewinnung;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextAccess (TextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop TextSchleife;
   
      return True;
      
   end SchriftartFestlegen;



   function SchriftgrößenFestlegen
     return Boolean
   is begin
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in TextAccessArray'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (SchriftgrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop SchriftgrößeSchleife;
      
      return True;

   end SchriftgrößenFestlegen;



   function SchriftfarbenFestlegen
     return Boolean
   is begin
                  
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in TextAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextAccess (SchriftfarbeSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop SchriftfarbeSchleife;
      
      return True;

   end SchriftfarbenFestlegen;
   
end StadtInformationenSFML;
