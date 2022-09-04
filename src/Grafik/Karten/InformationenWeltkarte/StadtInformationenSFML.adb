pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with StadtDatentypen; use StadtDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with GrafikRecordKonstanten;
with Views;
with GrafikDatentypen;

with LeseStadtGebaut;

with KampfwerteStadtErmitteln;
with GrafikEinstellungenSFML;
with TextberechnungenHoeheSFML;
with Vergleiche;
with HintergrundSFML;
with ViewsEinstellenSFML;
with NachLogiktask;
with GebaeudebeschreibungenSFML;
with EinheitenbeschreibungenSFML;
with TextberechnungenBreiteSFML;
with BerechnungenKarteSFML;

package body StadtInformationenSFML is
   
   -- Das hier an das neue Viewsystem anpassen oder direkt durch ein besseres System ersetzen? äöü
   procedure Stadtinformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.KartenviewAccess);
      
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    TextboxExtern      => BerechnungenKarteSFML.StadtKarte)
      is
         when True =>
            MausInformationen := True;
         
         when False =>
            MausInformationen := False;
      end case;
      
      Stadt (RasseExtern            => StadtRasseNummerExtern.Rasse,
             StadtRasseNummerExtern => StadtRasseNummerExtern);
      
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
      
   end Stadtinformationen;
   
   
   
   procedure Leer
   is begin
      
      -- Diese Bereiche sicherheitshalber auch von außen hineingeben? äöü
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.SeitenleisteWeltkarteAccesse (3),
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (3));
      
      HintergrundSFML.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                   AbmessungenExtern => Viewfläche);
      
   end Leer;
   
   

   procedure Stadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
                  
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.15, 0.05));
      
      Leer;
      
      Textposition := TextKonstanten.StartpositionText;
      AktuelleYPosition := Textposition.y;
      
      -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist und sich dort eine Stadt befindet.
      Stadtname (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Textbreite := 0.00;
      
      FestzulegenderText (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugEinwohner) & LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                              EinwohnerArbeiterExtern => True)'Wide_Wide_Image;
      
      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtRasseNummerExtern.Rasse = RasseExtern
        or
          SpielVariablen.Debug.VolleInformation
      then
         FestzulegenderText (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsproduktion) & " "
           & ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & " "
           & ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & " " &
           ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerteidigung) & KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAngriff) & KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (9) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugKorruption) & LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (10) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerfügbareArbeiter) & LeseStadtGebaut.Arbeitslose (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (11) := AktuellesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         FestzulegenderText (12) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeBauzeit) & LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
                                 
         VolleInformation := True;

      else
         VolleInformation := False;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         if
           VolleInformation = False
           and
             TextSchleifenwert > 2
         then
            null;
            
         else
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                          position => (Textposition.x, AktuelleYPosition));
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert));
                     
            Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                                                              TextbreiteExtern => Textbreite);
            
            AktuelleYPosition := AktuelleYPosition + TextberechnungenHoeheSFML.Zeilenabstand;
         end if;
         
         case
           TextSchleifenwert
         is
            when 11 =>
               Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
               AktuelleYPosition := AktuelleYPosition + TextberechnungenHoeheSFML.Zeilenabstand;
               
            when others =>
               null;
         end case;
      
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
      end loop TextSchleife;
            
      Debuginformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end Stadt;
   
   
   
   procedure Stadtname
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern)));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                    position => Textposition);
      
      -- Eventuell kann man das überall einbauen und so Text deutlich besser anpassen? äöü
      Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                        TextbreiteExtern => Textbreite);
      
      Sf.Graphics.Text.scale (text    => TextaccessVariablen.TextAccess,
                              factors => (Viewfläche.x / Textbreite, 1.00));
            
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.TextAccess);
      
      Sf.Graphics.Text.setScale (text  => TextaccessVariablen.TextAccess,
                                 scale => (1.00, 1.00));
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
      AktuelleYPosition := AktuelleYPosition + TextberechnungenHoeheSFML.Zeilenabstand;
      
   end Stadtname;
   
   
   
   function AktuellesBauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        Bauprojekt.Gebäude /= 0
      then
         Text := To_Unbounded_Wide_Wide_String (Source => GebaeudebeschreibungenSFML.BeschreibungKurz (IDExtern    => Bauprojekt.Gebäude,
                                                                                                       RasseExtern => StadtRasseNummerExtern.Rasse));
      
      elsif
        Bauprojekt.Einheit /= 0
      then
         Text := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenSFML.BeschreibungKurz (IDExtern    => Bauprojekt.Einheit,
                                                                                                        RasseExtern => StadtRasseNummerExtern.Rasse));
      
      else
         Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugKeines);
      end if;
      
      return Meldungstexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Text;
      
   end AktuellesBauprojekt;
   
   
   
   -- Debuginformationen einfach in die Konsole ausgeben lassen.
   procedure Debuginformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      if
        SpielVariablen.Debug.VolleInformation = False
        or
          SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.KI_Spieler_Enum
      then
         return;
         
      else
         null;
      end if;
      
   end Debuginformationen;
   
end StadtInformationenSFML;
