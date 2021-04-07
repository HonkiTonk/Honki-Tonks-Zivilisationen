pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, KartenPruefungen;

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
                  ZweiteYAchseSchleife:
                  for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     ZweiteXAchseSchleife:
                     for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     
                        KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                ZusatzYAbstandExtern => 0);

                        case
                          KartenWert.Erfolgreich
                        is
                           when False =>
                              exit ZweiteYAchseSchleife;
                                
                           when True =>
                              null;
                        end case;
                        
                        case
                          Karten.Weltkarte (0, KartenWert.YAchse, KartenWert.XAchse).Grund
                        is
                           when 3 =>
                              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 31;
                              exit ZweiteYAchseSchleife;

                           when others =>
                              null;
                        end case;
                        
                     end loop ZweiteXAchseSchleife;
                  end loop ZweiteYAchseSchleife;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungKüstenSeeGewässer;

end KartenGeneratorKueste;
