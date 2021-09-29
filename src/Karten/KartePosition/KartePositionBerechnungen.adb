pragma SPARK_Mode (On);

with KartenKonstanten;

with Karten;

package body KartePositionBerechnungen is

   function PositionBestimmenEAchseFest
     (EAchseExtern : in GlobaleDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in GlobaleDatentypen.EbeneVorhanden)
      return GlobaleDatentypen.Ebene
   is begin
      
      if
        EAchseExtern + ÄnderungEAchseExtern < Karten.WeltkarteArray'First (1)
        or
          EAchseExtern + ÄnderungEAchseExtern > Karten.WeltkarteArray'Last (1)
      then
         return GlobaleDatentypen.Ebene'First;
         
      else
         return EAchseExtern + ÄnderungEAchseExtern;
      end if;
      
   end PositionBestimmenEAchseFest;
   
   
   
   function PositionBestimmenYAchseFest
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in GlobaleDatentypen.Kartenfeld)
      return GlobaleDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        YAchseExtern + ÄnderungYAchseExtern < Karten.WeltkarteArray'First (2)
        or
          YAchseExtern + ÄnderungYAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         return GlobaleDatentypen.KartenfeldPositivMitNullwert'First;
         
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;
      
   end PositionBestimmenYAchseFest;
   
   
   
   function PositionBestimmenXAchseFest
     (XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in GlobaleDatentypen.Kartenfeld)
      return GlobaleDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern < Karten.WeltkarteArray'First (3)
        or
          XAchseExtern + ÄnderungXAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         return GlobaleDatentypen.KartenfeldPositivMitNullwert'First;
         
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;
      
   end PositionBestimmenXAchseFest;



   function PositionBestimmenXWechsel
     (XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in GlobaleDatentypen.Kartenfeld;
      ArrayPositionExtern : in GlobaleDatentypen.EbeneVorhanden)
      return GlobaleDatentypen.KartenfeldPositiv
   is begin

      if
        XAchseExtern + ÄnderungXAchseExtern < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (ArrayPositionExtern) := Integer (XAchseExtern + ÄnderungXAchseExtern + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (ArrayPositionExtern) < Positive (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangXAchse (ArrayPositionExtern) := ÜberhangXAchse (ArrayPositionExtern) + Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (ArrayPositionExtern));
               
      elsif
        XAchseExtern + ÄnderungXAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (ArrayPositionExtern) := Positive (XAchseExtern + ÄnderungXAchseExtern - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (ArrayPositionExtern) := ÜberhangXAchse (ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (ArrayPositionExtern));
               
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;

   end PositionBestimmenXWechsel;



   function PositionBestimmenYWechsel
     (YAchseExtern : in GlobaleDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in GlobaleDatentypen.Kartenfeld;
      ArrayPositionExtern : in GlobaleDatentypen.EbeneVorhanden)
      return GlobaleDatentypen.KartenfeldPositiv
   is begin

      if
        YAchseExtern + ÄnderungYAchseExtern < Karten.WeltkarteArray'First (2)
      then
         ÜberhangYAchse (ArrayPositionExtern) := Integer (YAchseExtern + ÄnderungYAchseExtern + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseKleinerSchleife:
         while ÜberhangYAchse (ArrayPositionExtern) < Positive (Karten.WeltkarteArray'First (2)) loop
            
            ÜberhangYAchse (ArrayPositionExtern) := ÜberhangYAchse (ArrayPositionExtern) + Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);

         end loop YAchseKleinerSchleife;
         return GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (ArrayPositionExtern));
               
      elsif
        YAchseExtern + ÄnderungYAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         ÜberhangYAchse (ArrayPositionExtern) := Positive (YAchseExtern + ÄnderungYAchseExtern - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseGrößerSchleife:
         while ÜberhangYAchse (ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) loop
            
            ÜberhangYAchse (ArrayPositionExtern) := ÜberhangYAchse (ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
            
         end loop YAchseGrößerSchleife;
         return GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (ArrayPositionExtern));
               
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;

   end PositionBestimmenYWechsel;
   
   
   
   function PositionBestimmen_Y_X_Wechsel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2)
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;

         if
           KoordinatenExtern.YAchse + ÄnderungExtern.YAchse = KartenKonstanten.LeerYAchse
         then
            return (0, 1, PolXAchse (KoordinatenExtern.EAchse));

         else
            return (0, abs (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse), PolXAchse (KoordinatenExtern.EAchse));
         end if;
               
      elsif
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PolXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
         
         if
           KoordinatenExtern.YAchse = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
           and
             ÄnderungExtern.YAchse = 1
         then
            return (0, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße, PolXAchse (KoordinatenExtern.EAchse));
            
         else
            return (0, abs (KoordinatenExtern.YAchse - ÄnderungExtern.YAchse), PolXAchse (KoordinatenExtern.EAchse));
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
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         if
           KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            PolYAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            PolYAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;

         if
           KoordinatenExtern.XAchse + ÄnderungExtern.XAchse = KartenKonstanten.LeerXAchse
         then
            return (0, PolYAchse (KoordinatenExtern.EAchse), 1);

         else
            return (0, PolYAchse (KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse));
         end if;
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            PolYAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));

         else
            PolYAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
         end if;
         
         if
           KoordinatenExtern.XAchse = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
           and
             ÄnderungExtern.XAchse = 1
         then
            return (0, PolYAchse (KoordinatenExtern.EAchse), Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         else
            return (0, PolYAchse (KoordinatenExtern.EAchse), abs (KoordinatenExtern.XAchse - ÄnderungExtern.XAchse));
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
