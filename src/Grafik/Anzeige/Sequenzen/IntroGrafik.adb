with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Views;
with TextaccessVariablen;
with GrafikDatentypen;
with Sequenzentexte;
with GrafikKonstanten;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with ZeilenumbruchberechnungGrafik;

package body IntroGrafik is

   procedure Intro
   is begin
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.AbspannviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            -- Warum benutze ich denn für das Intro auch den Abspannbereich und habe keinen eigenen Introbereich oder generell einen Sequenzenbereich? äöü
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Abspannbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Intro_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      Textbreite := GrafikKonstanten.Nullwert;
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         -- Ergibt die Kombination aus ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung und TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln überhaupt Sinn? äöü
         TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                 TextExtern       => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung
                                                                   (TextExtern           => To_Wide_Wide_String (Source => Sequenzentexte.Intro (IntroSchleifenwert)),
                                                                    TextfeldbreiteExtern => Viewfläche.x,
                                                                    BreitenabzugExtern   => Textposition.x),
                                                                 PositionExtern   => Textposition);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
      end loop IntroSchleife;
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end Intro;

end IntroGrafik;
