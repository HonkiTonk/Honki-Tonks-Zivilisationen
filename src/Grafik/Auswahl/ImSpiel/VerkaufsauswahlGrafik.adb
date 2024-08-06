with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Spieltexte;
with TextnummernKonstanten;
with GrafikDatentypen;
with Views;
with ViewKonstanten;

with AllgemeineViewsGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with BauauswahlGrafik;
with InteraktionAuswahl;

package body VerkaufsauswahlGrafik is

   procedure Verkaufsauswahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AktuelleAuswahlExtern : in StadtDatentypen.GebäudeID)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Spieltexte.Fragen (TextnummernKonstanten.FrageGebäudeverkauf)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Enum,
                                          SpielenamenExtern => False);
      
      Gebäude (AuswahlExtern => AktuelleAuswahlExtern,
                SpeziesExtern => SpeziesExtern);
      
   end Verkaufsauswahl;
   
   
   
   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudelisteVerkaufen).width,
                                                                                              GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudelisteVerkaufen).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BauviewAccesse (ViewKonstanten.BaumenüGebäudelisteVerkaufen),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Baumenübereich (ViewKonstanten.BaumenüGebäudelisteVerkaufen));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Bauen_Enum,
                                     AbmessungenExtern => Viewfläche);
                  
      Viewfläche.y := BauauswahlGrafik.Gebäude (AuswahlExtern        => AuswahlExtern,
                                                  SpeziesExtern        => SpeziesExtern,
                                                  BauenVerkaufenExtern => False,
                                                  BaulisteExtern       => InteraktionAuswahl.MöglicheBauoptionen);
      
   end Gebäude;

end VerkaufsauswahlGrafik;
