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
         when KartenKonstanten.KartenformXZylinderKonstante =>
            return KartePositionKartenformen.KartenPositionXZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                      ÄnderungExtern    => ÄnderungExtern);
            
         when KartenKonstanten.KartenformYZylinderKonstante =>
            return KartePositionKartenformen.KartenPositionYZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                      ÄnderungExtern    => ÄnderungExtern);
            
         when KartenKonstanten.KartenformTorusKonstante =>
            return KartePositionKartenformen.KartenPositionTorus (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern);
            
         when KartenKonstanten.KartenformKugelKonstante =>
            return KartePositionKartenformen.KartenPositionKugel (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern);
            
         when KartenKonstanten.KartenformViereckKonstante =>
            return KartePositionKartenformen.KartenPositionViereck (KoordinatenExtern => KoordinatenExtern,
                                                                    ÄnderungExtern    => ÄnderungExtern);

         when KartenKonstanten.KartenformKugelGedrehtKonstante =>
            return KartePositionKartenformen.KartenPositionKugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                         ÄnderungExtern    => ÄnderungExtern);
            
            -- Hier soll er die Sachen aus Kugel und Torus zusammen machen
         when KartenKonstanten.KartenformTugelKonstante =>
            return KartePositionKartenformen.KartenPositionTugel (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern);
            
         when KartenKonstanten.KartenformTugelGedrehtKonstante =>
            return (0, 0, 0);
            
         when KartenKonstanten.KartenformTugelExtremKonstante =>
            return (0, 0, 0);
      end case;
      
   end KartenPositionBestimmen;
   
end KartePositionPruefen;
