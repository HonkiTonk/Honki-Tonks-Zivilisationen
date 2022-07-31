pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.View;

with EinheitenDatentypen; use EinheitenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with StadtDatentypen; use StadtDatentypen;
with GlobaleTexte;
with KartenVerbesserungDatentypen;
with TextKonstanten;
with TextaccessVariablen;

with LeseStadtGebaut;

with GesamtwerteFeld;
with KampfwerteStadtErmitteln;
with GrafikEinstellungenSFML;
with Fehler;
with TextberechnungenHoeheSFML;
with BerechnungenKarteSFML;
with HintergrundSFML;
with ViewsEinstellenSFML;
with ViewsSFML;

package body StadtInformationenSFML is
   
   procedure Stadtinformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern    => ViewsSFML.SeitenleisteKartenviewAccess,
                                          GrößeExtern   => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y)),
                                          ZentrumExtern => (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00));
      HintergrundSFML.SeitenleisteHintergrund;
      
      TextPosition := Stadt (RasseExtern            => StadtRasseNummerExtern.Rasse,
                             StadtRasseNummerExtern => StadtRasseNummerExtern,
                             AnzeigeAnfangenExtern  => StartpunktText);
      
      if
        GrafikEinstellungenSFML.MausPosition.x in Sf.sfInt32 (0.00) .. Sf.sfInt32 (BerechnungenKarteSFML.StadtKarte.x)
        and
          GrafikEinstellungenSFML.MausPosition.y in Sf.sfInt32 (0.00) .. Sf.sfInt32 (BerechnungenKarteSFML.StadtKarte.y)
      then
         MausInformationen := True;
         
      else
         MausInformationen := False;
      end if;
      
      -- Werden die Mausinformationen in der SFML Version überhaupt benötigt?
      case
        MausInformationen
      is
         when True =>
            -- Hier eventuell Informationen wie den Gebäudenamen und was das Gebäude macht einbauen?
            null;
            
         when False =>
            null;
      end case;
      
      Sf.Graphics.View.setViewport (view     => ViewsSFML.SeitenleisteKartenviewAccess,
                                    viewport => (0.80, 0.00, 0.80, 1.00));
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                        view         => ViewsSFML.StandardviewAccess);
      
   end Stadtinformationen;
   
   

   function Stadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AnzeigeAnfangenExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      TextPosition := AnzeigeAnfangenExtern;
      
      -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist und sich dort eine Stadt befindet.
      StadtartName (RasseExtern            => RasseExtern,
                    StadtRasseNummerExtern => StadtRasseNummerExtern);
      Einwohner (StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtRasseNummerExtern.Rasse = RasseExtern
        or
          SpielVariablen.Debug.VolleInformation
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
         
         VolleInformation := True;

      else
         VolleInformation := False;
      end if;
            
      TextPosition.y := TextPosition.y - TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.StadtInformationenAccessArray'Range loop
         
         if
           VolleInformation = False
           and
             TextSchleifenwert > 2
         then
            exit TextSchleife;
            
         else
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert));
         end if;
         
      end loop TextSchleife;
      
      return TextPosition;
      
   end Stadt;
   
   

   procedure StadtartName
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      -- Diese Anzeige komplett in die Kartenanzeige verschieben? äöü
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "StadtInformationenSFML.StadtartName - Existierende Stadt existiert nicht.");
            
         when KartenVerbesserungDatentypen.Hauptstadt_Enum =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 1;

            else
               Stadtart := 3;
            end if;
            
         when KartenVerbesserungDatentypen.Stadt_Enum =>
            if
              RasseExtern = StadtRasseNummerExtern.Rasse
            then
               Stadtart := 2;
               
            else
               Stadtart := 4;
            end if;
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (1),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (Stadtart)) & " " & StadtName (StadtRasseNummerExtern => StadtRasseNummerExtern));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (1),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end StadtartName;
   
   
   
   function StadtName
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
   end StadtName;
   
   
   
   procedure Einwohner
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringEinwohner (ZahlExtern => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                       EinwohnerArbeiterExtern => True));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (2),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugEinwohner)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (2),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Einwohner;
   
   
   
   procedure AktuelleNahrungsmittel
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (3),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugNahrungsmittel)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (3),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuelleNahrungsmittel;
   
   
   
   procedure AktuelleNahrungsproduktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (4),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugNahrungsproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (4),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuelleNahrungsproduktion;
   
   
   
   procedure AktuelleProduktionrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (5),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugRessourcenproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (5),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuelleProduktionrate;
   
   
   
   procedure AktuelleGeldgewinnung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (6),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGeldproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (6),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuelleGeldgewinnung;
   
   
   
   procedure AktuelleForschungsrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (7),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugWissensproduktion)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (7),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuelleForschungsrate;
   
   
   
   procedure AktuelleVerteidigung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (8),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerteidigung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (8),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (9),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAngriff)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (9),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuellerAngriff;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (10),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugKorruption)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (10),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Korruption;
   
   
   
   procedure EinwohnerOhneArbeit
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringEinwohner (ZahlExtern => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                       EinwohnerArbeiterExtern => True)
                                                      - LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                           EinwohnerArbeiterExtern => False));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (11),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerfügbareArbeiter)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (11),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end EinwohnerOhneArbeit;
   
   
   
   procedure AktuellesBauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        Bauprojekt.Gebäude = 0
        and
          Bauprojekt.Einheit = 0
      then
         Text := GlobaleTexte.Zeug (28);
            
      elsif
        Bauprojekt.Gebäude /= 0
      then
         Text := GlobaleTexte.Gebäude (2 * Natural (Bauprojekt.Gebäude) - 1);

      else
         Text := GlobaleTexte.Einheiten (2 * Natural (Bauprojekt.Einheit) - 1);
      end if;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (12),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugBauprojekt)) & " " & To_Wide_Wide_String (Source => Text));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (12),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (13),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerbleibendeBauzeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (13),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuellesBauprojekt;
   
   
   
   procedure EinzelnesFeldNahrungsgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                                                                      RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (14),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugNahrungsgewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (14),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end EinzelnesFeldNahrungsgewinnung;
   
   
   
   procedure EinzelnesFeldRessourcengewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                                                         RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (15),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugRessourcengewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (15),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end EinzelnesFeldRessourcengewinnung;
   
   
   
   procedure EinzelnesFeldGeldgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                                                                   RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (16),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGeldgewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (16),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end EinzelnesFeldGeldgewinnung;
   
   
   
   procedure EinzelnesFeldWissensgewinnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringProduktionFeld (ZahlExtern => GesamtwerteFeld.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                                                                     RasseExtern       => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (17),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugWissensgewinnung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (17),
                                    position => TextPosition);
      
      TextPosition.y := TextPosition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end EinzelnesFeldWissensgewinnung;
   
end StadtInformationenSFML;
