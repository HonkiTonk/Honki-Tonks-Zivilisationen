pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with StadtKonstanten;
with KartenDatentypen;

with LeseStadtGebaut;

with GesamtwerteFeld;
with KampfwerteStadtErmitteln;
with Cheat;
with GrafikTextAllgemein;
with GrafikEinstellungen;
with Fehler;

package body StadtInformationenSFML is

   function Stadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AnzeigeAnfangenExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      TextPosition := AnzeigeAnfangenExtern;
      Zeilenabstand := Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße) * 0.15;
      
      GrafikTextAllgemein.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                                FontAccessExtern   => GrafikEinstellungen.SchriftartAccess,
                                                SchriftgrößeExtern => GrafikEinstellungen.FensterEinstellungen.Schriftgröße,
                                                FarbeExtern        => GrafikEinstellungen.Schriftfarben.FarbeStandardText);
      
      -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist und sich dort eine Stadt befindet.
      StadtartName (RasseExtern            => RasseExtern,
                    StadtRasseNummerExtern => StadtRasseNummerExtern);
      Einwohner (StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder wenn Cheat aktiviert ist.
      if
        StadtRasseNummerExtern.Rasse = RasseExtern
        or
          Cheat.FeindlicheInformationenSehen
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
      
      return TextPosition;
      
   end Stadt;
   
   

   procedure StadtartName
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      -- Diese Anzeige komplett in die Kartenanzeige verschieben? 
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenDatentypen.Leer =>
            Fehler.GrafikStopp (FehlermeldungExtern => "StadtInformationenSFML.StadtArtBesitzer - Stadt sollte existieren tut sie aber nicht.");
            
         when KartenDatentypen.Eigene_Hauptstadt =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 1;

            else
               Stadtart := 3;
            end if;
                  
         when KartenDatentypen.Eigene_Stadt =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 2;
                        
            else
               Stadtart := 4;
            end if;
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (Stadtart)) & " " & StadtName (StadtRasseNummerExtern => StadtRasseNummerExtern));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
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
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (5)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Einwohner;
   
   
   
   procedure AktuelleNahrungsmittel
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (6)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuelleNahrungsmittel;
   
   
   
   procedure AktuelleNahrungsproduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (7)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuelleNahrungsproduktion;
   
   
   
   procedure AktuelleProduktionrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (8)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuelleProduktionrate;
   
   
   
   procedure AktuelleGeldgewinnung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (9)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuelleGeldgewinnung;
   
   
   
   procedure AktuelleForschungsrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (10)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuelleForschungsrate;
   
   
   
   procedure AktuelleVerteidigung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (25)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (24)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuellerAngriff;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (11)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Korruption;
   
   
   
   procedure EinwohnerOhneArbeit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                            EinwohnerArbeiterExtern => True)
                                                           - LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                EinwohnerArbeiterExtern => False));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (41)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end EinwohnerOhneArbeit;
   
   
   
   procedure AktuellesBauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer = StadtKonstanten.LeerBauprojekt.Nummer
      then
         Text := GlobaleTexte.ZeugSachen (28);
            
      elsif
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).GebäudeEinheit = True
      then
         Text := GlobaleTexte.Gebäude (2 * Natural (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer) - 1);

      else
         Text := GlobaleTexte.Einheiten (2 * Natural (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer) - 1);
      end if;
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (12)) & To_Wide_Wide_String (Source => Text));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (13)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuellesBauprojekt;
   
   
   
   procedure EinzelnesFeldNahrungsgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                                                                      RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (20)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end EinzelnesFeldNahrungsgewinnung;
   
   
   
   procedure EinzelnesFeldRessourcengewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                                                         RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (21)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end EinzelnesFeldRessourcengewinnung;
   
   
   
   procedure EinzelnesFeldGeldgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                                                                   RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (22)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end EinzelnesFeldGeldgewinnung;
   
   
   
   procedure EinzelnesFeldWissensgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                                                                     RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (23)) & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => TextPosition);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.FensterAccess,
                                         text         => TextAccess);
      
      TextPosition.y := TextPosition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end EinzelnesFeldWissensgewinnung;

end StadtInformationenSFML;
