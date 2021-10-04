pragma SPARK_Mode (On);

with KartePositionKartenformen;

package body KartePositionPruefen is
   
   function KartenPositionBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      case
        Karten.Kartenform
      is
         when KartenDatentypen.X_Zylinder =>
            return KartePositionKartenformen.KartenPositionXZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                      ÄnderungExtern    => ÄnderungExtern);
            
         when KartenDatentypen.Y_Zylinder =>
            return KartePositionKartenformen.KartenPositionYZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                      ÄnderungExtern    => ÄnderungExtern);
            
         when KartenDatentypen.Torus =>
            return KartePositionKartenformen.KartenPositionTorus (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern);
            
         when KartenDatentypen.Kugel =>
            return KartePositionKartenformen.KartenPositionKugel (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern);
            
         when KartenDatentypen.Viereck =>
            return KartePositionKartenformen.KartenPositionViereck (KoordinatenExtern => KoordinatenExtern,
                                                                    ÄnderungExtern    => ÄnderungExtern);

         when KartenDatentypen.Kugel_Gedreht =>
            return KartePositionKartenformen.KartenPositionKugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                         ÄnderungExtern    => ÄnderungExtern);
            
            -- Hier soll er die Sachen aus Kugel und Torus zusammen machen
         when KartenDatentypen.Tugel =>
            return KartePositionKartenformen.KartenPositionTugel (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern);
            
         when KartenDatentypen.Tugel_Gedreht =>
            return (0, 0, 0);
            
         when KartenDatentypen.Tugel_Extrem =>
            return (0, 0, 0);
      end case;
      
   end KartenPositionBestimmen;
   
end KartePositionPruefen;
