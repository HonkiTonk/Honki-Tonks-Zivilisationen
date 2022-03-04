pragma SPARK_Mode (On);

package body KartePositionVerschobenerUebergangBerechnungen is
   
   function PositionBestimmen_Y_X_Wechsel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2)
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;

         if
           KoordinatenExtern.YAchse + ÄnderungExtern.YAchse = KartenKonstanten.LeerYAchse
         then
            return (KoordinatenExtern.EAchse, 1, XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse));

         else
            return (KoordinatenExtern.EAchse, abs (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse), XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse));
         end if;
               
      elsif
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
         
         if
           KoordinatenExtern.YAchse = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
           and
             ÄnderungExtern.YAchse = 1
         then
            return (KoordinatenExtern.EAchse, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße, XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse));
            
         else
            return (KoordinatenExtern.EAchse, abs (KoordinatenExtern.YAchse - ÄnderungExtern.YAchse), XAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse));
         end if;
               
      else
         null;
      end if;

      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse = KartenKonstanten.LeerYAchse
      then
         return (KoordinatenExtern.EAchse, 1, KoordinatenExtern.XAchse);

      else
         return (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse);
      end if;
      
   end PositionBestimmen_Y_X_Wechsel;
   
   
   
   function PositionBestimmen_X_Y_Wechsel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         if
           KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;

         if
           KoordinatenExtern.XAchse + ÄnderungExtern.XAchse = KartenKonstanten.LeerXAchse
         then
            return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), 1);

         else
            return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse));
         end if;
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;
         
         if
           KoordinatenExtern.XAchse = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
           and
             ÄnderungExtern.XAchse = 1
         then
            return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         else
            return (KoordinatenExtern.EAchse, YAchseZwischenwert (LogikGrafikExtern, KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse - ÄnderungExtern.XAchse));
         end if;
               
      else
         null;
      end if;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse = KartenKonstanten.LeerXAchse
      then
         return (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, 1);

      else
         return (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end PositionBestimmen_X_Y_Wechsel;

end KartePositionVerschobenerUebergangBerechnungen;
