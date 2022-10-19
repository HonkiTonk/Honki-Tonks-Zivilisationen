pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with Views;
with TextaccessVariablen;
with GrafikDatentypen;
with Spieltexte;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with ZeilenumbruchberechnungGrafik;

package body IntroGrafik is

   procedure Intro
   is begin
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.AbspannviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Abspannbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Intro_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textbreite := 0.00;
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
      
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                       position => Textposition);
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                            str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => To_Wide_Wide_String (Source => Spieltexte.Intro (IntroSchleifenwert)),
                                                                                                           TextfeldbreiteExtern => (Viewfläche.x / 2.00 - Textposition.x)));
      
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
        
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.IntroAccess (IntroSchleifenwert));
         
      end loop IntroSchleife;
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end Intro;

end IntroGrafik;
