pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with GlobaleTexte;
with TextnummernKonstanten;

with LeseWichtiges;

with ForschungAllgemein;
with GrafikEinstellungenSFML;
with TextberechnungenHoeheSFML;

package body KarteWichtigesSFML is

   function WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition := TextpositionExtern;
      TextbreiteAktuell := 0.00;
      
      FestzulegenderText (1) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuellePosition) & " " & ZahlAlsStringEbeneVorhanden (ZahlExtern => KoordinatenExtern.EAchse) & "," & KoordinatenExtern.YAchse'Wide_Wide_Image
        & "," & KoordinatenExtern.XAchse'Wide_Wide_Image;
      
      -- Wieso gibt es keine Lese/Schreibefunktion für die Rundenanzahl? äöü
      FestzulegenderText (2) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & SpielVariablen.Allgemeines.Rundenanzahl'Wide_Wide_Image;
      
      FestzulegenderText (3) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (RasseExtern => RasseExtern)'Wide_Wide_Image;
      FestzulegenderText (4) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuellerGeldzuwachs) & " " & ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern));
      FestzulegenderText (5) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " " & ForschungAllgemein.Beschreibung (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern),
                                                                                                                                           RasseExtern => RasseExtern);
      FestzulegenderText (6) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeForschungszeit) & LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern)'Wide_Wide_Image;
      FestzulegenderText (7) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuelleForschungsmenge) & LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern)'Wide_Wide_Image;
      FestzulegenderText (8) := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugAktuellerForschungsgewinn) & LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern)'Wide_Wide_Image;
            
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteWichtigesAccessArray'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                       position => Textposition);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert));
         
         TextbreiteNeu := Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert)).width + 2.00 * TextpositionExtern.x;
         
         if
           TextbreiteAktuell < TextbreiteNeu
         then
            TextbreiteAktuell := TextbreiteNeu;
            
         else
            null;
         end if;
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
         
      end loop TextSchleife;
      
      Textposition.x := TextbreiteAktuell;
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      return Textposition;
      
   end WichtigesInformationen;

end KarteWichtigesSFML;
