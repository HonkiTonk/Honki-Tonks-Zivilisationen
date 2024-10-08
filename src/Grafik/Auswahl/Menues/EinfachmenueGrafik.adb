with Sf.Graphics.Text;

with TextaccessVariablen;
with MenueKonstanten;
with InteraktionAuswahl;
with Views;
with GrafikDatentypen;
with GrafikKonstanten;
with ViewKonstanten;

with TextberechnungenBreiteGrafik;
with MenuestringsSetzenGrafik;
with ZusatztextaufteilungGrafik;
with TextberechnungenHoeheGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;

package body EinfachmenueGrafik is

   procedure Einfachmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Integer)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.MenüEinfachbereich.width, GrafikRecordKonstanten.MenüEinfachbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.MenüEinfachbereich);
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => Viewfläche);
      
      Viewbreite := Viewfläche.x;
                  
      Viewfläche := Textdarstellung (WelchesMenüExtern     => WelchesMenüExtern,
                                      ViewflächeExtern      => Viewfläche,
                                      AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Zusatztext_Einfach_Enum'Range =>
            Viewfläche := ZusatztextaufteilungGrafik.Zusatztextaufteilung (WelchesMenüExtern     => WelchesMenüExtern,
                                                                            AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                                                            ViewflächeExtern      => Viewfläche,
                                                                            RealeViewbreiteExtern => Viewbreite);
            
         when others =>
            null;
      end case;
      
      Viewfläche.y := Viewfläche.y + TextberechnungenHoeheGrafik.Zeilenabstand;
                              
   end Einfachmenü;
   
   
   
   function Textdarstellung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Integer)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textbreite := GrafikKonstanten.Nullwert;

      PositionenSchleife:
      for PositionSchleifenwert in MenueKonstanten.StandardArrayanpassung .. MenueKonstanten.EndeAbzugGrafik (WelchesMenüExtern) loop
      
         TextaccessverwaltungssystemEinfachGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                             TextExtern       => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => PositionSchleifenwert,
                                                                                                                              WelchesMenüExtern => WelchesMenüExtern),
                                                             FarbeExtern      => TextfarbeGrafik.FarbeEinfachmenü (WelchesMenüExtern    => WelchesMenüExtern,
                                                                                                                    AktuelleAuswahlExtern => AktuelleAuswahlExtern + MenueKonstanten.SchleifenanpassungGrafikLogik,
                                                                                                                    AktuellerTextExtern   => PositionSchleifenwert));
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                                 ViewbreiteExtern => ViewflächeExtern.x);
         
         TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                    PositionExtern   => Textposition);

         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert));
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand);

   end Textdarstellung;

end EinfachmenueGrafik;
