with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Views;
with TextaccessVariablen;
with GrafikDatentypen;
with Sequenzentexte;
with GrafikKonstanten;

with SchreibeGrafiktask;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextaccessverwaltungssystemErweitertGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with ZeilenumbruchberechnungGrafik;

package body IntroGrafik is

   procedure Intro
   is begin
      
      case
        Titel
      is
         when False =>
            return;
            
         when True =>
            null;
      end case;
      
      case
        Namen
      is
         when False =>
            return;
            
         when True =>
            SchreibeGrafiktask.IntroBeenden (JaNeinExtern => True);
      end case;
      
   end Intro;
   
   
   
   function Titel
     return Boolean
   is begin
      
      case
        Spielstart
      is
         when True =>
            Startzeit := Clock;
            Spielstart := False;
      
            Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
            
         when False =>
            null;
      end case;
            
      -- Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => Viewfläche,
                                                                                         VerhältnisExtern => (GrafikRecordKonstanten.Abspannbereich.width,
                                                                                                               GrafikRecordKonstanten.Abspannbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.AbspannviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            -- Warum benutze ich denn für das Intro auch den Abspannbereich und habe keinen eigenen Introbereich oder generell einen Sequenzenbereich? äöü
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Abspannbereich);
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Intro_Eins_Enum,
                                    AbmessungenExtern => Viewfläche);
            
      TextaccessverwaltungssystemEinfachGrafik.Text (TextaccessExtern => TextaccessVariablen.TestGroßAccess,
                                                     TextExtern       => SonstigesKonstanten.Spielname);
            
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TestGroßAccess,
                                                                              ViewbreiteExtern => Viewfläche.x);
      
      if
        Textposition.x < 0.00
      then
         Textposition.x := 0.00;
         
      else
         null;
      end if;
               
      Leerwert := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => Introtext,
                                                                                    TextpositionExtern       => Textposition,
                                                                                    MaximaleTextbreiteExtern => Viewfläche.x,
                                                                                    TextAccessExtern         => TextaccessVariablen.TestGroßAccess);
      
      if
        Startzeit + Buchstabenanzeige * Duration (AktuellerBuchstabe + 1) < Clock
      then
         if
           AktuellerBuchstabe = Introtext'Last
         then
            AktuellerBuchstabe := AktuellerBuchstabe + 1;
            
         elsif
           AktuellerBuchstabe > Introtext'Last
         then
            return True;
               
         else
            AktuellerBuchstabe := AktuellerBuchstabe + 1;
            Introtext (AktuellerBuchstabe) := SonstigesKonstanten.Spielname (AktuellerBuchstabe);
         end if;
         
      else
         null;
      end if;
      
      return False;
      
   end Titel;
   
   
   
   function Namen
     return Boolean
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.AbspannviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            -- Warum benutze ich denn für das Intro auch den Abspannbereich und habe keinen eigenen Introbereich oder generell einen Sequenzenbereich? äöü
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Abspannbereich);
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Intro_Eins_Enum,
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
      
      return True;
      
   end Namen;

end IntroGrafik;
