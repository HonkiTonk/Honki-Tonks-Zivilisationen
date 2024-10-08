with Sf.Graphics.Text;

with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with MenueKonstanten;
with GrafikKonstanten;
with InteraktionAuswahl;
with ViewKonstanten;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextfarbeGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with MenuestringsSetzenGrafik;
with ZusatztextaufteilungGrafik;
with KartenformmenueGrafik;
with TextaccessverwaltungssystemEinfachGrafik;

package body DoppelmenueGrafik is

   procedure Doppelmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
            
      Viewfläche (Auswahlbereich) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Auswahlbereich),
                                                                                         VerhältnisExtern => (GrafikRecordKonstanten.MenüDoppelbereich (Auswahlbereich).width,
                                                                                                               GrafikRecordKonstanten.MenüDoppelbereich (Auswahlbereich).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl),
                                            GrößeExtern          => Viewfläche (Auswahlbereich),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.MenüDoppelbereich (Auswahlbereich));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => Viewfläche (Auswahlbereich));
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Spezies_Menü_Enum =>
            Viewfläche (Auswahlbereich) := TextpositionFestlegen (WelchesMenüExtern     => WelchesMenüExtern,
                                                                   ViewflächeExtern      => Viewfläche (Auswahlbereich),
                                                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            Viewfläche (Auswahlbereich) := KartenformmenueGrafik.Kartenformmenü (WelchesMenüExtern     => WelchesMenüExtern,
                                                                                   ViewflächeExtern      => Viewfläche (Auswahlbereich),
                                                                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end case;

      Viewfläche (Auswahlbereich).y := Viewfläche (Auswahlbereich).y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;


      
      Viewfläche (Zusatzbereich) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Zusatzbereich),
                                                                                        VerhältnisExtern => (GrafikRecordKonstanten.MenüDoppelbereich (Zusatzbereich).width,
                                                                                                              GrafikRecordKonstanten.MenüDoppelbereich (Zusatzbereich).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccesse (ViewKonstanten.MenüZusatztext),
                                            GrößeExtern          => Viewfläche (Zusatzbereich),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.MenüDoppelbereich (Zusatzbereich));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => Viewfläche (Zusatzbereich));

      Viewfläche (Zusatzbereich) := ZusatztextaufteilungGrafik.ZusatztextDoppelmenü (WelchesMenüExtern     => WelchesMenüExtern,
                                                                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                                                                       ViewflächeExtern      => Viewfläche (Zusatzbereich));
      
      Viewfläche (Zusatzbereich).y := Viewfläche (Zusatzbereich).y + TextberechnungenHoeheGrafik.Zeilenabstand;
      
   end Doppelmenü;
   
   
   
   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textbreite := GrafikKonstanten.Nullwert;

      PositionenSchleife:
      for PositionSchleifenwert in MenueKonstanten.StandardArrayanpassung .. MenueKonstanten.EndeAbzugGrafik (WelchesMenüExtern) loop
      
         TextaccessverwaltungssystemEinfachGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                             TextExtern       => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => PositionSchleifenwert,
                                                                                                                              WelchesMenüExtern => WelchesMenüExtern),
                                                             FarbeExtern      => TextfarbeGrafik.FarbeDoppelmenü (AktuellerTextExtern   => PositionSchleifenwert,
                                                                                                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern + MenueKonstanten.SchleifenanpassungGrafikLogik));
                  
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

      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);

   end TextpositionFestlegen;

end DoppelmenueGrafik;
