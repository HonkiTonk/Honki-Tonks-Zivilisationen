pragma SPARK_Mode (On);

with KartePositionNormaleKartenformen;
with KartePositionAbstrakteKartenformen;
with KartenEinstellungenKonstanten;

package body KarteKoordinatenPruefen is
   
   function KarteKoordinatenPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      -- Mal neu/fertig schreiben.
      -- Die Prüfung wird ständig aufgerufen, müssten die Renderer und die Mausbewegung sein. Kann man diese Aufrufe reduzieren?
      -- Die Arrays sind da wegen der Parallelisierung der Kartenfelderbewertung und weil das hier von Logik und Grafik benötigt wird.
      -- Vielleicht sollte man die Contracts auch überarbeiten, wenn man das System an sich überarbeitet?
      
      case
        Karten.Kartenform
      is
         -- Normale Kartenformen
         when KartenEinstellungenKonstanten.KartenformXZylinderKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionXZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                             ÄnderungExtern    => ÄnderungExtern,
                                                                             LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformYZylinderKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionYZylinder (KoordinatenExtern => KoordinatenExtern,
                                                                             ÄnderungExtern    => ÄnderungExtern,
                                                                             LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformTorusKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionTorus (KoordinatenExtern => KoordinatenExtern,
                                                                         ÄnderungExtern    => ÄnderungExtern,
                                                                         LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformKugelKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionKugel (KoordinatenExtern => KoordinatenExtern,
                                                                         ÄnderungExtern    => ÄnderungExtern,
                                                                         LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformViereckKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionViereck (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => ÄnderungExtern,
                                                                           LogikGrafikExtern => LogikGrafikExtern);

         when KartenEinstellungenKonstanten.KartenformKugelGedrehtKonstante =>
            return KartePositionNormaleKartenformen.KartenPositionKugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                                ÄnderungExtern    => ÄnderungExtern,
                                                                                LogikGrafikExtern => LogikGrafikExtern);
            -- Normale Kartenformen
            
            
            
            -- Abstrakte Kartenformen
         when KartenEinstellungenKonstanten.KartenformTugelKonstante =>
            return KartePositionAbstrakteKartenformen.KartenPositionTugel (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => ÄnderungExtern,
                                                                           LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformTugelGedrehtKonstante =>
            return KartePositionAbstrakteKartenformen.KartenPositionTugelGedreht (KoordinatenExtern => KoordinatenExtern,
                                                                                  ÄnderungExtern    => ÄnderungExtern,
                                                                                  LogikGrafikExtern => LogikGrafikExtern);
            
         when KartenEinstellungenKonstanten.KartenformTugelExtremKonstante =>
            return KartePositionAbstrakteKartenformen.KartenPositionTugelExtrem (KoordinatenExtern => KoordinatenExtern,
                                                                                 ÄnderungExtern    => ÄnderungExtern,
                                                                                 LogikGrafikExtern => LogikGrafikExtern);
            
            
            -- Abstrakte Kartenformen
      end case;
      
   end KarteKoordinatenPrüfen;
   
end KarteKoordinatenPruefen;
