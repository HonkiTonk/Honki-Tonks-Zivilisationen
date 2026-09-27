with ViewKonstanten;
with Views;
with GrafikDatentypen;

with ObjekteZeichnenGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;

package body ScrollleisteGrafik is
   
   procedure Scrollen
     (AbschnittExtern : in Natural)
   is begin
      
      ViewflächeScrollen := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => ViewflächeScrollen,
                                                                                                 VerhältnisExtern => (GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungScrollleiste).width,
                                                                                                                       GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungScrollleiste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungScrollleiste),
                                            GrößeExtern          => ViewflächeScrollen,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungScrollleiste));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Hinweis_Enum,
                                    AbmessungenExtern => ViewflächeScrollen);
            
      Leistenabschnitt := ViewflächeScrollen.y / Float (InteraktionAuswahl.PositionenSteuerungsleiste'Last);
      
      PositionenSchleife:
      for PositionenSchleifenwert in InteraktionAuswahl.PositionenSteuerungsleiste'Range loop
         
         InteraktionAuswahl.PositionenSteuerungsleiste (PositionenSchleifenwert) := (0.00, Float (PositionenSchleifenwert - 1) * Leistenabschnitt, ViewflächeScrollen.x, Leistenabschnitt);
         
      end loop PositionenSchleife;
      
      ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => (ViewflächeScrollen.x, Leistenabschnitt),
                                              PositionExtern  => (0.00, Float (AbschnittExtern) * Leistenabschnitt),
                                              FarbeExtern     => GrafikRecordKonstanten.Fehlerfarbe);
      
   end Scrollen;

end ScrollleisteGrafik;
