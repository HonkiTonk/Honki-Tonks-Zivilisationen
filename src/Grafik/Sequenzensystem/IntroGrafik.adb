with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Views;
with TextaccessVariablen;
with GrafikDatentypen;
with Sequenzentexte;
with GrafikKonstanten;
with NamenKonstanten;

with SchreibeGrafiktask;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextaccessverwaltungssystemErweitertGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;

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
        Entwickler
      is
         when False =>
            return;
            
         when True =>
            null;
      end case;
      
      case
        Helfer
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
        StartSpiel
      is
         when True =>
            ZeitStart := Clock;
            StartSpiel := False;
            
         when False =>
            null;
      end case;
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => Viewfläche,
                                                                                         VerhältnisExtern => (GrafikRecordKonstanten.Sequenzbereich.width,
                                                                                                               GrafikRecordKonstanten.Sequenzbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.AbspannviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Sequenzbereich);
      
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
        ZeitStart + Buchstabenanzeige * Duration (AktuellerBuchstabe + 1) < Clock
      then
         if
           AktuellerBuchstabe = Introtext'Last
         then
            AktuellerBuchstabe := AktuellerBuchstabe + 1;
            
         elsif
           AktuellerBuchstabe > Introtext'Last
         then
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
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
   
   
   
   function Entwickler
     return Boolean
   is begin
      
      case
        StartEntwickler
      is
         when True =>
            ZeitEntwickler := Clock;
            StartEntwickler := False;
            
         when False =>
            null;
      end case;
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      Textbreite := GrafikKonstanten.Nullwert;
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'First .. TextaccessVariablen.IntroAccess'First loop
         
         TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                        TextExtern       => To_Wide_Wide_String (Source => Sequenzentexte.Intro (IntroSchleifenwert)),
                                                                        PositionExtern   => Textposition);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
         
         Textposition.x := Textposition.x + TextberechnungenBreiteGrafik.Spaltenabstand;
         Farbe := Sf.Graphics.Color.sfRed;
         
         TextaccessverwaltungssystemEinfachGrafik.TextPositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.TestMittelAccess,
                                                                             TextExtern       => NamenKonstanten.Entwickler,
                                                                             PositionExtern   => Textposition,
                                                                             FarbeExtern      => Farbe);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
      end loop IntroSchleife;
      
      Viewfläche := (Textbreite, Textposition.y);
      
      if
        ZeitEntwickler + Anzeigezeit < Clock
      then
         return True;
               
      else
         return False;
      end if;
            
   end Entwickler;
   
   
   
   function Helfer
     return Boolean
   is begin
      
      case
        StartHelfer
      is
         when True =>
            ZeitHelfer := Clock;
            StartHelfer := False;
            
         when False =>
            null;
      end case;
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      Textbreite := GrafikKonstanten.Nullwert;
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Last .. TextaccessVariablen.IntroAccess'Last loop
                  
         TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                        TextExtern       => To_Wide_Wide_String (Source => Sequenzentexte.Intro (IntroSchleifenwert)),
                                                                        PositionExtern   => Textposition);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => 0.00);
         
         Textposition.x := Textposition.x + TextberechnungenBreiteGrafik.Spaltenabstand;
         Farbe := Sf.Graphics.Color.sfRed;
         
         TextaccessverwaltungssystemEinfachGrafik.TextPositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.TestMittelAccess,
                                                                             TextExtern       => To_Wide_Wide_String (Source => NamenKonstanten.Helfer (1)),
                                                                             PositionExtern   => Textposition,
                                                                             FarbeExtern      => Farbe);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
      end loop IntroSchleife;
      
      Viewfläche := (Textbreite, Textposition.y);
      
      if
        ZeitHelfer + Anzeigezeit < Clock
      then
         return True;
               
      else
         return False;
      end if;
      
   end Helfer;

end IntroGrafik;
