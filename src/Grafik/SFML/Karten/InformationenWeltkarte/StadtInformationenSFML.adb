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
with TextKonstanten;
with TextnummernKonstanten;

with LeseStadtGebaut;

with KampfwerteStadtErmitteln;
with GrafikEinstellungenSFML;
with TextberechnungenHoeheSFML;
with BerechnungenKarteSFML;
with HintergrundSFML;
with ViewsEinstellenSFML;
with ViewsSFML;

package body StadtInformationenSFML is
   
   procedure Stadtinformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Viewfläche.y := StartpunktText.y + TextberechnungenHoeheSFML.KleinerZeilenabstand * Float ((TextaccessVariablen.KarteWichtigesAccessArray'Last + TextaccessVariablen.KarteAllgemeinesAccessArray'Last
                                                                                                  + TextaccessVariablen.StadtInformationenAccessArray'Last));
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern    => ViewsSFML.SeitenleisteKartenviewAccess,
                                          GrößeExtern   => Viewfläche);
      HintergrundSFML.SeitenleisteHintergrund (AbmessungenExtern => Viewfläche);
      
      Textposition := Stadt (RasseExtern            => StadtRasseNummerExtern.Rasse,
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
      
      Viewfläche.x := Textposition.x;
      
      Sf.Graphics.View.setViewport (view     => ViewsSFML.SeitenleisteKartenviewAccess,
                                    viewport => (0.80, 0.00, 0.20, 1.00));
      
      Sf.Graphics.RenderWindow.setView (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                        view         => ViewsSFML.StandardviewAccess);
      
   end Stadtinformationen;
   
   

   -- Vielleicht einen Boolean mit reingeben um so die Informationen noch einmal zwischen Weltkarte und in der Stadt zu unterteilen? äöü
   function Stadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AnzeigeAnfangenExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      TextpositionStadt := AnzeigeAnfangenExtern;
      TextbreiteAktuell := 0.00;
      
      -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist und sich dort eine Stadt befindet.
      FestzulegenderText (1) := LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern);
      FestzulegenderText (2) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugEinwohner) & LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                      EinwohnerArbeiterExtern => True)'Wide_Wide_Image;

      -- Volle Stadtinformationen, nur sichtbar wenn eigene Stadt oder durch Debug.
      if
        StadtRasseNummerExtern.Rasse = RasseExtern
        or
          SpielVariablen.Debug.VolleInformation
      then
         FestzulegenderText (3) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (4) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugNahrungsproduktion) & " "
           & ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (5) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & " "
           & ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (6) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & " " &
           ZahlAlsStringGesamtproduktionStadt (ZahlExtern => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern));
         FestzulegenderText (7) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (8) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugVerteidigung) & KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (9) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAngriff) & KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (10) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugKorruption) & LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (11) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugVerfügbareArbeiter) & LeseStadtGebaut.Arbeitslose (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
         FestzulegenderText (12) := AktuellesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         FestzulegenderText (13) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeBauzeit) & LeseStadtGebaut.Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image;
                                 
         VolleInformation := True;

      else
         VolleInformation := False;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.StadtInformationenAccessArray'Range loop
         
         if
           VolleInformation = False
           and
             TextSchleifenwert > 2
         then
            exit TextSchleife;
            
         else
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                               str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert),
                                          position => TextpositionStadt);
            
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert));
         
            if
              TextSchleifenwert = 1
              and
                To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern))'Length > 50
            then
               null;
               
            else
               TextbreiteNeu := Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtInformationenAccess (TextSchleifenwert)).width + 2.00 * AnzeigeAnfangenExtern.x;
         
               if
                 TextbreiteAktuell < TextbreiteNeu
               then
                  TextbreiteAktuell := TextbreiteNeu;
            
               else
                  null;
               end if;
            end if;
         end if;
         
         case
           TextSchleifenwert
         is
            when 12 =>
               TextpositionStadt.y := TextpositionStadt.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
               
            when others =>
               null;
         end case;
      
         TextpositionStadt.y := TextpositionStadt.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
         
      end loop TextSchleife;
      
      TextpositionStadt.x := TextbreiteAktuell;
      TextpositionStadt.y := TextpositionStadt.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      Debuginformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      return TextpositionStadt;
      
   end Stadt;
   
   
   
   function AktuellesBauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Unbounded_Wide_Wide_String
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
      
      return GlobaleTexte.Zeug (TextnummernKonstanten.ZeugBauprojekt) & TextKonstanten.UmbruchAbstand & Text;
      
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
