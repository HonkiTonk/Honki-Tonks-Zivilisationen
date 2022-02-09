pragma SPARK_Mode (On);

with KartePositionKartenformen;

package body KartePositionPruefen is
   
   function KartenPositionBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      -- Mal neu/fertig schreiben.
      -- Die Prüfung wird ständig aufgerufen, müssten die Renderer und die Mausbewegung sein. Kann man diese Aufrufe reduzieren?
      -- Die Arrays sind da wegen der Parallelisierung der Kartenfelderbewertung.
      
      case
        Karten.Kartenform
      is
         when KartenKonstanten.KartenformXZylinderKonstante =>
            return KartePositionKartenformen.KartenPositionXZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                      ÄnderungExtern    => ÄnderungExtern,
                                                                      LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenKonstanten.KartenformYZylinderKonstante =>
            return KartePositionKartenformen.KartenPositionYZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                      ÄnderungExtern    => ÄnderungExtern,
                                                                      LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenKonstanten.KartenformTorusKonstante =>
            return KartePositionKartenformen.KartenPositionTorus (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern,
                                                                  LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenKonstanten.KartenformKugelKonstante =>
            return KartePositionKartenformen.KartenPositionKugel (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern,
                                                                  LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenKonstanten.KartenformViereckKonstante =>
            return KartePositionKartenformen.KartenPositionViereck (KoordinatenExtern => KoordinatenExtern,
                                                                    ÄnderungExtern    => ÄnderungExtern,
                                                                    LogikGrafikExtern => LogikGrafikExtern);

         when KartenKonstanten.KartenformKugelGedrehtKonstante =>
            return KartePositionKartenformen.KartenPositionKugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                         ÄnderungExtern    => ÄnderungExtern,
                                                                         LogikGrafikExtern => LogikGrafikExtern);
            
            -- Hier soll er die Sachen aus Kugel und Torus zusammen machen
         when KartenKonstanten.KartenformTugelKonstante =>
            return KartePositionKartenformen.KartenPositionTugel (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => ÄnderungExtern,
                                                                  LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenKonstanten.KartenformTugelGedrehtKonstante =>
            return (0, 0, 0);
            
         when KartenKonstanten.KartenformTugelExtremKonstante =>
            return (0, 0, 0);
      end case;
      
   end KartenPositionBestimmen;
   
end KartePositionPruefen;
