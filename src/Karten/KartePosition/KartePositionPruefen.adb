pragma SPARK_Mode (On);

with KartePositionKartenformen;

package body KartePositionPruefen is
   
   function KartenPositionBestimmen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      case
        Karten.Kartenform
      is
         when GlobaleDatentypen.X_Zylinder =>
            return KartePositionKartenformen.KartenPositionXZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                      ÄnderungExtern    => ÄnderungExtern);
            
         when GlobaleDatentypen.Y_Zylinder =>
            return KartePositionKartenformen.KartenPositionYZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                      ÄnderungExtern    => ÄnderungExtern);
            
         when GlobaleDatentypen.Torus =>
            return KartePositionKartenformen.KartenPositionTorus (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern);
            
         when GlobaleDatentypen.Kugel =>
            return KartePositionKartenformen.KartenPositionKugel (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern);
            
         when GlobaleDatentypen.Viereck =>
            return KartePositionKartenformen.KartenPositionViereck (KoordinatenExtern => KoordinatenExtern,
                                                                    ÄnderungExtern    => ÄnderungExtern);

         when GlobaleDatentypen.Kugel_Gedreht =>
            return KartePositionKartenformen.KartenPositionKugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                         ÄnderungExtern    => ÄnderungExtern);
            
            -- Hier soll er die Sachen aus Kugel und Torus zusammen machen
         when GlobaleDatentypen.Tugel =>
            return KartePositionKartenformen.KartenPositionTugel (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern);
            
         when GlobaleDatentypen.Tugel_Gedreht =>
            return (0, 0, 0);
            
         when GlobaleDatentypen.Tugel_Extrem =>
            return (0, 0, 0);
      end case;
      
   end KartenPositionBestimmen;
   
end KartePositionPruefen;
