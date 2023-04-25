with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Views;
with TextaccessVariablen;
with GrafikDatentypen;
with Spieltexte;
with GrafikKonstanten;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextaccessverwaltungssystemGrafik;
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
      Textbreite := GrafikKonstanten.Nullwert;
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                 TextExtern       => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung
                                                                   (TextExtern           => To_Wide_Wide_String (Source => Spieltexte.Intro (IntroSchleifenwert)),
                                                                    TextfeldbreiteExtern => (Viewfläche.x / GrafikKonstanten.Halbierung - Textposition.x)),
                                                                 PositionExtern   => Textposition);
      
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
      end loop IntroSchleife;
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end Intro;

end IntroGrafik;
