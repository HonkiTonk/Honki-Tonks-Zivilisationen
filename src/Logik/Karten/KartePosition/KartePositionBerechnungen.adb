pragma SPARK_Mode (On);

with KartenKonstanten;

with Karten;

package body KartePositionBerechnungen is

   function PositionBestimmenEAchseFest
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.Ebene
   is begin
      
      if
        EAchseExtern + ÄnderungEAchseExtern < Karten.WeltkarteArray'First (1)
        or
          EAchseExtern + ÄnderungEAchseExtern > Karten.WeltkarteArray'Last (1)
      then
         return KartenDatentypen.Ebene'First;
         
      else
         return EAchseExtern + ÄnderungEAchseExtern;
      end if;
      
   end PositionBestimmenEAchseFest;
   
   
   
   function PositionBestimmenYAchseFest
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        YAchseExtern + ÄnderungYAchseExtern < Karten.WeltkarteArray'First (2)
        or
          YAchseExtern + ÄnderungYAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         return KartenDatentypen.KartenfeldPositivMitNullwert'First;
         
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;
      
   end PositionBestimmenYAchseFest;
   
   
   
   function PositionBestimmenXAchseFest
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern < Karten.WeltkarteArray'First (3)
        or
          XAchseExtern + ÄnderungXAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         return KartenDatentypen.KartenfeldPositivMitNullwert'First;
         
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;
      
   end PositionBestimmenXAchseFest;



   function PositionBestimmenXWechsel
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin

      if
        XAchseExtern + ÄnderungXAchseExtern < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (XAchseExtern + ÄnderungXAchseExtern + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) < Positive (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) + Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return KartenDatentypen.Kartenfeld (ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      elsif
        XAchseExtern + ÄnderungXAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (XAchseExtern + ÄnderungXAchseExtern - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return KartenDatentypen.Kartenfeld (ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;

   end PositionBestimmenXWechsel;



   function PositionBestimmenYWechsel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin

      if
        YAchseExtern + ÄnderungYAchseExtern < Karten.WeltkarteArray'First (2)
      then
         ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (YAchseExtern + ÄnderungYAchseExtern + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseKleinerSchleife:
         while ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) < Positive (Karten.WeltkarteArray'First (2)) loop
            
            ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) + Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);

         end loop YAchseKleinerSchleife;
         return KartenDatentypen.Kartenfeld (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      elsif
        YAchseExtern + ÄnderungYAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (YAchseExtern + ÄnderungYAchseExtern - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseGrößerSchleife:
         while ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) loop
            
            ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
            
         end loop YAchseGrößerSchleife;
         return KartenDatentypen.Kartenfeld (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;

   end PositionBestimmenYWechsel;
   
   
   
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
            PolXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PolXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;

         if
           KoordinatenExtern.YAchse + ÄnderungExtern.YAchse = KartenKonstanten.LeerYAchse
         then
            return (0, 1, PolXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));

         else
            return (0, abs (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse), PolXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
         end if;
               
      elsif
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            PolXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PolXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
         
         if
           KoordinatenExtern.YAchse = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
           and
             ÄnderungExtern.YAchse = 1
         then
            return (0, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße, PolXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
            
         else
            return (0, abs (KoordinatenExtern.YAchse - ÄnderungExtern.YAchse), PolXAchse (LogikGrafikExtern, KoordinatenExtern.EAchse));
         end if;
               
      else
         null;
      end if;

      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse = KartenKonstanten.LeerYAchse
      then
         return (0, 1, KoordinatenExtern.XAchse);

      else
         return (0, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse);
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
            PolYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            PolYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;

         if
           KoordinatenExtern.XAchse + ÄnderungExtern.XAchse = KartenKonstanten.LeerXAchse
         then
            return (0, PolYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), 1);

         else
            return (0, PolYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse));
         end if;
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            PolYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            PolYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;
         
         if
           KoordinatenExtern.XAchse = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
           and
             ÄnderungExtern.XAchse = 1
         then
            return (0, PolYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         else
            return (0, PolYAchse (LogikGrafikExtern, KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse - ÄnderungExtern.XAchse));
         end if;
               
      else
         null;
      end if;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse = KartenKonstanten.LeerXAchse
      then
         return (0, KoordinatenExtern.YAchse, 1);

      else
         return (0, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end PositionBestimmen_X_Y_Wechsel;

end KartePositionBerechnungen;
