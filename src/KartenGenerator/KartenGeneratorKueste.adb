pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartePositionPruefen;

package body KartenGeneratorKueste is

   procedure GenerierungKüstenSeeGewässer
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                              
            case
              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund
            is
               when 2 =>
                  GewässerFestlegen (YAchseSchleifenwertExtern => YAchseSchleifenwert,
                                      XAchseSchleifenwertExtern => XAchseSchleifenwert);
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungKüstenSeeGewässer;
   
   
   
   procedure GewässerFestlegen
     (YAchseSchleifenwertExtern, XAchseSchleifenwertExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
      
      ZweiteYAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         ZweiteXAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseSchleifenwertExtern, XAchseSchleifenwertExtern),
                                                                        ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                        ZusatzYAbstandExtern => 0);
                        
            exit ZweiteXAchseSchleife when KartenWert.XAchse = 0;
                        
            case
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund
            is
               when 3 =>
                  Karten.Weltkarte (0, YAchseSchleifenwertExtern, XAchseSchleifenwertExtern).Grund := 31;
                  exit ZweiteYAchseSchleife;

               when others =>
                  null;
            end case;
                        
         end loop ZweiteXAchseSchleife;
      end loop ZweiteYAchseSchleife;
      
   end GewässerFestlegen;

end KartenGeneratorKueste;
