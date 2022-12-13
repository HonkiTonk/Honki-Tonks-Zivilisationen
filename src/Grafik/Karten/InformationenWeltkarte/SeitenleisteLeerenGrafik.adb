with Views;
with GrafikDatentypen;

with ViewsEinstellenGrafik;
with HintergrundGrafik;

package body SeitenleisteLeerenGrafik is

   function Leer
     (AnzeigebereichExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeExtern,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Weltkartenbereich (AnzeigebereichExtern).width,
                                                                                              GrafikRecordKonstanten.Weltkartenbereich (AnzeigebereichExtern).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.WeltkarteAccess (AnzeigebereichExtern),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (AnzeigebereichExtern));
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Seitenleiste_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      return Viewfläche;
      
   end Leer;

end SeitenleisteLeerenGrafik;
