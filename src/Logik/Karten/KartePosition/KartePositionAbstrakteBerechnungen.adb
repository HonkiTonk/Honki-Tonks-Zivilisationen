pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
-- with KartenKonstanten;

with Karten;
with KartePositionNormaleBerechnungen;

package body KartePositionAbstrakteBerechnungen is

   function PositionBestimmen_Y_X_WechselTugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2)
        or
          KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
         
         YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenYWechsel (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                                         ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                                         ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                         LogikGrafikExtern    => LogikGrafikExtern);
               
         return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse));
           
      else
         return (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse);
      end if;
      
   end PositionBestimmen_Y_X_WechselTugel;
   
   
   
   function PositionBestimmen_X_Y_WechselTugel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
        or
          KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;
         
         XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KartePositionNormaleBerechnungen.PositionBestimmenXWechsel (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                                         ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                                         ArrayPositionExtern  => KoordinatenExtern.EAchse,
                                                                                                                                         LogikGrafikExtern    => LogikGrafikExtern);
               
         return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse));
         
      else
         return (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end PositionBestimmen_X_Y_WechselTugel;
   
   
   
   function PositionBestimmenEWechsel
     (EAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungEAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin

      if
        EAchseExtern + ÄnderungEAchseExtern < Karten.WeltkarteArray'First (3)
      then
         ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (EAchseExtern + ÄnderungEAchseExtern + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         
         XAchseKleinerSchleife:
         while ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) < Positive (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) + Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         
         return KartenDatentypen.Kartenfeld (ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      elsif
        EAchseExtern + ÄnderungEAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (EAchseExtern + ÄnderungEAchseExtern - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         
         XAchseGrößerSchleife:
         while ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         
         return KartenDatentypen.Kartenfeld (ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      else
         return EAchseExtern + ÄnderungEAchseExtern;
      end if;

   end PositionBestimmenEWechsel;

end KartePositionAbstrakteBerechnungen;
