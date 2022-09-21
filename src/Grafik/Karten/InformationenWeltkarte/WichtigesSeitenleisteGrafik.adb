pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with Meldungstexte;
with TextnummernKonstanten;
with Views;
with GrafikDatentypen;
with TextKonstanten;

with LeseWichtiges;

with ForschungsbeschreibungenGrafik;
with EinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;

package body WichtigesSeitenleisteGrafik is

   procedure WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ViewbereichExtern : in Positive)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (0.15, 0.05));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SeitenleisteWeltkarteAccesse (ViewbereichExtern),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.SeitenleisteWeltkartenbereich (ViewbereichExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textbreite := 0.00;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      FestzulegenderText (1) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellePosition) & " " & ZahlAlsStringEbeneVorhanden (ZahlExtern => KoordinatenExtern.EAchse) & "," & KoordinatenExtern.YAchse'Wide_Wide_Image
        & "," & KoordinatenExtern.XAchse'Wide_Wide_Image;
      
      FestzulegenderText (2) := Rundenanzahl (RasseExtern => RasseExtern);
      
      FestzulegenderText (3) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (RasseExtern => RasseExtern)'Wide_Wide_Image;
      FestzulegenderText (4) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellerGeldzuwachs) & " " & ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern));
      FestzulegenderText (5) := Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & " "
        & ForschungsbeschreibungenGrafik.BeschreibungKurz (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern),
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
                  
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert));
         
      end loop TextSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
   end WichtigesInformationen;
   
   
   
   -- Wieso gibt es keine Lese/Schreibefunktion für die Rundenanzahl? äöü
   -- Vermutlich weil sie meistens nur gelesen und nur am Rundenende oder beim Standard setzen aufgerufen wird? äöü
   function Rundenanzahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     return Unbounded_Wide_Wide_String
   is begin
                  
      case
        SpielVariablen.Grenzen (RasseExtern).RassenRundengrenze
      is
         when 0 =>
            null;
            
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & SpielVariablen.Allgemeines.Rundenanzahl'Wide_Wide_Image & TextKonstanten.Trennzeichen
              & ZahlAlsStringPositive (ZahlExtern => SpielVariablen.Grenzen (RasseExtern).RassenRundengrenze);
      end case;
      
      case
        SpielVariablen.Allgemeines.Rundengrenze
      is
         when 0 =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & SpielVariablen.Allgemeines.Rundenanzahl'Wide_Wide_Image;
            
         when others =>
            return Meldungstexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & SpielVariablen.Allgemeines.Rundenanzahl'Wide_Wide_Image & TextKonstanten.Trennzeichen
              & ZahlAlsStringPositive (ZahlExtern => SpielVariablen.Allgemeines.Rundengrenze);
      end case;
      
   end Rundenanzahl;

end WichtigesSeitenleisteGrafik;
