pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with Meldungstexte;
with TextnummernKonstanten;
with Views;
with GrafikRecordKonstanten;
with GrafikDatentypen;

with LeseWichtiges;

with ForschungsbeschreibungenSFML;
with GrafikEinstellungenSFML;
with TextberechnungenHoeheSFML;
with TextberechnungenBreiteSFML;
with HintergrundSFML;
with ViewsEinstellenSFML;

package body KarteWichtigesSFML is

   procedure WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Viewfläche := ViewsEinstellenSFML.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                      VerhältnisExtern => (0.15, 0.05));
      
      -- Diese Bereiche sicherheitshalber auch von außen hineingeben? äöü
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.SeitenleisteWeltkarteAccesse (1),
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (1));
      
      HintergrundSFML.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                   AbmessungenExtern => Viewfläche);
      
      Textbreite := 0.00;
      Textposition := TextKonstanten.StartpositionText;
      
      FestzulegenderText (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellePosition) & " " & ZahlAlsStringEbeneVorhanden (ZahlExtern => KoordinatenExtern.EAchse) & "," & KoordinatenExtern.YAchse'Wide_Wide_Image
        & "," & KoordinatenExtern.XAchse'Wide_Wide_Image;
      
      -- Wieso gibt es keine Lese/Schreibefunktion für die Rundenanzahl? äöü
      FestzulegenderText (2) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & SpielVariablen.Allgemeines.Rundenanzahl'Wide_Wide_Image;
      
      FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (RasseExtern => RasseExtern)'Wide_Wide_Image;
      FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellerGeldzuwachs) & " " & ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern));
      FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " "
        & ForschungsbeschreibungenSFML.BeschreibungKurz (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern),
                                                         RasseExtern => RasseExtern);
      FestzulegenderText (6) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugVerbleibendeForschungszeit) & LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern)'Wide_Wide_Image;
      FestzulegenderText (7) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleForschungsmenge) & LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern)'Wide_Wide_Image;
      FestzulegenderText (8) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellerForschungsgewinn) & LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern)'Wide_Wide_Image;
            
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)));
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                       position => Textposition);
                  
         Textbreite := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                                                           TextbreiteExtern => Textbreite);
         
         Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand;
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert));
         
      end loop TextSchleife;
      
      Viewfläche := (Textbreite, Textposition.y);
            
   end WichtigesInformationen;

end KarteWichtigesSFML;
