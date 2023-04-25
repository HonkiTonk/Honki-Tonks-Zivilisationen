with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with Meldungstexte;
with TextnummernKonstanten;
with GrafikDatentypen;
with Views;
with TextaccessVariablen;
with InteraktionAuswahl;
with ViewKonstanten;
with GrafikKonstanten;

with AllgemeineViewsGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextfarbeGrafik;
with BauauswahlGebaeudeGrafik;
with TextaccessverwaltungssystemGrafik;

package body VerkaufsauswahlGrafik is

   procedure Verkaufsauswahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AktuelleAuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Meldungstexte.Frage (TextnummernKonstanten.FrageGebäudeverkauf)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                          SpielenamenExtern => False);
      
      Gebäude (AuswahlExtern => AktuelleAuswahlExtern,
                SpeziesExtern => SpeziesExtern);
      
      BauauswahlGebaeudeGrafik.Gebäudeinformationen (AuswahlExtern     => AktuelleAuswahlExtern,
                                                      SpeziesExtern     => SpeziesExtern,
                                                      ViewbereichExtern => ViewKonstanten.BaumenüGebäudeinformationenVerkaufen);
      
   end Verkaufsauswahl;
   
   
   
   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudelisteVerkaufen).width,
                                                                                              GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudelisteVerkaufen).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüGebäudelisteVerkaufen),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudelisteVerkaufen));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      AktuelleTextbreite := GrafikKonstanten.Nullwert;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                                                       ViewbreiteExtern => Viewfläche.x);
               
               TextaccessverwaltungssystemGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                                        PositionExtern   => Textposition,
                                                                        FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Positive (GebäudeSchleifenwert),
                                                                                                                                   AuswahlExtern    => Natural (AuswahlExtern)));
                                                                      
               Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                               TextAccessExtern => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                                               ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
               
               AktuelleTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert),
                                                                                           TextbreiteExtern => AktuelleTextbreite);
               
               InteraktionAuswahl.PositionenMöglicheGebäude (GebäudeSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.GebäudetextAccess (SpeziesExtern, GebäudeSchleifenwert));

            when False =>
               null;
         end case;
                                                                               
      end loop GebäudeSchleife;
      
      Viewfläche := (AktuelleTextbreite, Textposition.y);
      
   end Gebäude;

end VerkaufsauswahlGrafik;
