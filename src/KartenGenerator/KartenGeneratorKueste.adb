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
               when GlobaleDatentypen.Wasser =>
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
                                                                        ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                        
            if
              KartenWert.XAchse = 0
              or else
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund /= GlobaleDatentypen.Flachland
            then
               null;
               
            else
               Karten.Weltkarte (0, YAchseSchleifenwertExtern, XAchseSchleifenwertExtern).Grund := GlobaleDatentypen.Küstengewässer;
            end if;
                        
         end loop ZweiteXAchseSchleife;
      end loop ZweiteYAchseSchleife;
      
   end GewässerFestlegen;

end KartenGeneratorKueste;
