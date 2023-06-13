with TextaccessVariablen;
with Views;

with TextaccessverwaltungssystemGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;

package body BildrateAnzeigenGrafik is
   
   -- Eine Anzeige einbauen bei der die wissenschaftliche Anzeige verwendet wird? äöü
   -- generell wieder als Float anzeigen? äöü
   procedure Bildrate
   is begin
      
      AktuelleBildrate := Positive (Float'Floor (1.00 / Float (Clock - LetzteZeit)));
      LetzteZeit := Clock;
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Bildratenbereich.width,
                                                                                              GrafikRecordKonstanten.Bildratenbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.BildratenviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Bildratenbereich);
      
      TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.BildrateAccess,
                                                              TextExtern       => AktuelleBildrate'Wide_Wide_Image,
                                                              PositionExtern   => (5.00, 5.00));
      
      Viewfläche.x := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.BildrateAccess,
                                                                             TextbreiteExtern => 5.00);
      
      Viewfläche.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => 5.00,
                                                                     TextAccessExtern => TextaccessVariablen.BildrateAccess,
                                                                     ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
   end Bildrate;

end BildrateAnzeigenGrafik;
