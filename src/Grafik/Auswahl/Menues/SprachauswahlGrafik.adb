pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with GrafikDatentypen;
with TextKonstanten;
with InteraktionAuswahl;
with TextaccessVariablen;
with Views;

with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TexteinstellungenGrafik;
with NachGrafiktask;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with AllgemeineViewsGrafik;

package body SprachauswahlGrafik is
   
   procedure Sprachauswahl
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Sprachenbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      case
        Erstaufruf
      is
         when True =>
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                      font => TexteinstellungenGrafik.SchriftartAccess);
            Erstaufruf := False;
            
         when False =>
            null;
      end case;
      
      -- Diese Werter später in die Prozedur übergeben, außer die Sprachen? äöü
      MehrereSeiten := NachGrafiktask.MehrereSeiten;
      AktuelleAuswahl := NachGrafiktask.AktuelleAuswahl.AuswahlEins;
      Ende := NachGrafiktask.Endauswahl;
      AktuelleSprachen := AuswahlSprache.AktuelleSprachen;
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      AktuelleTextbreite := 0.00;
      
      -- Dann einfach von 1 bis 11 loopen und entsprechend leer lassen, sollte hinhauen. äöü
      AnzeigeSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'First .. Ende loop
         
         if
           AktuelleAuswahl = ZeileSchleifenwert
         then
            AktuelleTextFarbe := TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
            
         else
            AktuelleTextFarbe := TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
         end if;
         
         if
           MehrereSeiten = False
           or
             (MehrereSeiten
              and
                ZeileSchleifenwert < Ende)
         then
            -- Alle Textaccesse nach dem Erzeugen des Fenster setzen und dann noch einmal nach der Sprachauswahl? äöü
            -- Dann würde alles doppelt gesetzt werden, dafür müsste ich hier weniger einstellen. äöü
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SprachauswahlAccess,
                                               str  => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)));
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SprachauswahlAccess,
                                       color => AktuelleTextFarbe);
            
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                                    ViewbreiteExtern => Viewfläche.x);
            
            Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SprachauswahlAccess,
                                          position => Textposition);
            
            NeueTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                                    TextbreiteExtern => 0.00);
            
            InteraktionAuswahl.PositionenSprachauswahl (ZeileSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SprachauswahlAccess);
            
            -- Den Textteil in ein Array packen und bei leeren Zeilen einfach nichts darstellen? äöü
            Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                               text         => TextaccessVariablen.SprachauswahlAccess);
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
                        
         elsif
           MehrereSeiten
           and
             ZeileSchleifenwert = Ende
         then
            -- Das später wie bei der Versionsnummer regeln? Dafür dann auch mal eine universellere Lösung finden. äöü
            Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
            
            Sf.Graphics.ConvexShape.setPointCount (shape => PfeilAccess,
                                                   count => 7);
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 0,
                                              point => (0.00, 0.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 1,
                                              point => (40.00, 0.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 2,
                                              point => (40.00, -15.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 3,
                                              point => (70.00, 10.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 4,
                                              point => (40.00, 35.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 5,
                                              point => (40.00, 20.00));
            Sf.Graphics.ConvexShape.setPoint (shape => PfeilAccess,
                                              index => 6,
                                              point => (0.00, 20.00));
            
            Sf.Graphics.ConvexShape.setFillColor (shape => PfeilAccess,
                                                  color => AktuelleTextFarbe);
            
            Textposition.x := Viewfläche.x / 2.00 - 0.50 * Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess).width;
            
            Sf.Graphics.ConvexShape.setPosition (shape    => PfeilAccess,
                                                 position => Textposition);
            
            InteraktionAuswahl.PositionenSprachauswahl (ZeileSchleifenwert) := Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess);
            
            NeueTextbreite := TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess).width;
            
            Sf.Graphics.RenderWindow.drawConvexShape (renderWindow => EinstellungenGrafik.FensterAccess,
                                                      object       => PfeilAccess);
            
            Textposition.y := Textposition.y + Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess).height + TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
            
         else
            NeueTextbreite := 0.00;
         end if;
         
         if
           NeueTextbreite > AktuelleTextbreite
         then
            AktuelleTextbreite := NeueTextbreite;
            
         else
            null;
         end if;
         
      end loop AnzeigeSchleife;
      
      -- Funktioniert aktuell nur nach Einlesen/Setzen aller Texte/Textaccesse und zeigt deswegen nur bei einem späteren Sprachwechsel die Versionsnummer an.
      -- So lassen oder anpassen? äöü
      AllgemeineViewsGrafik.Versionsnummer (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum);
      
      Viewfläche := (AktuelleTextbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end Sprachauswahl;

end SprachauswahlGrafik;
