with Sf.Graphics.Text;

with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with MenueKonstanten;
with GrafikKonstanten;
with InteraktionAuswahl;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextfarbeGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with MenuestringsSetzenGrafik;
with ZusatztextaufteilungGrafik;
with KartenformmenueGrafik;
with TextaccessverwaltungssystemGrafik;

package body DoppelmenueGrafik is

   procedure Doppelmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      AktuelleAuswahlExtern : in Natural)
   is begin
      
      Viewfläche (Auswahlbereich) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Auswahlbereich),
                                                                                         VerhältnisExtern => (GrafikRecordKonstanten.MenüDoppelbereich (Auswahlbereich).width,
                                                                                                               GrafikRecordKonstanten.MenüDoppelbereich (Auswahlbereich).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccess,
                                            GrößeExtern          => Viewfläche (Auswahlbereich),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.MenüDoppelbereich (Auswahlbereich));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
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

      Viewfläche (Auswahlbereich).y := Viewfläche (Auswahlbereich).y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;


      
      Viewfläche (Zusatzbereich) := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche (Zusatzbereich),
                                                                                        VerhältnisExtern => (GrafikRecordKonstanten.MenüDoppelbereich (Zusatzbereich).width,
                                                                                                              GrafikRecordKonstanten.MenüDoppelbereich (Zusatzbereich).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ZusatztextviewAccess,
                                            GrößeExtern          => Viewfläche (Zusatzbereich),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.MenüDoppelbereich (Zusatzbereich));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche (Zusatzbereich));

      Viewfläche (Zusatzbereich) := ZusatztextaufteilungGrafik.ZusatztextDoppelmenü (WelchesMenüExtern     => WelchesMenüExtern,
                                                                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                                                                       ViewflächeExtern      => Viewfläche (Zusatzbereich));
      
      Viewfläche (Zusatzbereich).y := Viewfläche (Zusatzbereich).y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      
   end Doppelmenü;
   
   
   
   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := GrafikKonstanten.Nullwert;

      PositionenSchleife:
      for PositionSchleifenwert in MenueKonstanten.StandardArrayanpassung .. MenueKonstanten.EndeAbzugGrafik (WelchesMenüExtern) loop
      
         TextaccessverwaltungssystemGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                      TextExtern       => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => PositionSchleifenwert,
                                                                                                                       WelchesMenüExtern => WelchesMenüExtern),
                                                      FarbeExtern      => TextfarbeGrafik.FarbeDoppelmenü (AktuellerTextExtern   => PositionSchleifenwert,
                                                                                                            AktuelleAuswahlExtern => AktuelleAuswahlExtern + 1));
                  
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                                 ViewbreiteExtern => ViewflächeExtern.x);
         
         TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                             PositionExtern   => Textposition);

         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert - 1)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert));
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.MenüsAccess (WelchesMenüExtern, PositionSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
                  
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);

   end TextpositionFestlegen;

end DoppelmenueGrafik;
