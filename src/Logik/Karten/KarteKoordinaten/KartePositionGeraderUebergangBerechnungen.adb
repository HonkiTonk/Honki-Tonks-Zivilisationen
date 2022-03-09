pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;

with Karten;

package body KartePositionGeraderUebergangBerechnungen is
   
   function PositionBestimmenEWechsel
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.EbeneVorhanden
   is begin

      if
        EAchseExtern + ÄnderungEAchseExtern < Karten.WeltkarteArray'First (1)
      then
         ZwischenwertEAchse (LogikGrafikExtern, ArrayPositionExtern) := abs (Integer (ÄnderungEAchseExtern));
         ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (EAchseExtern);
         
         EAchseKleinerSchleife:
         while ZwischenwertEAchse (LogikGrafikExtern, ArrayPositionExtern) > 0 loop
            
            if
              ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) - 1 < Integer (Karten.WeltkarteArray'First (1))
            then
               ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (Karten.WeltkarteArray'Last (1));
               
            else
               ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) - 1;
            end if;
            
            ZwischenwertEAchse (LogikGrafikExtern, ArrayPositionExtern) := ZwischenwertEAchse (LogikGrafikExtern, ArrayPositionExtern) - 1;
            
         end loop EAchseKleinerSchleife;
         
         return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      elsif
        EAchseExtern + ÄnderungEAchseExtern > Karten.WeltkarteArray'Last (1)
      then
         ZwischenwertEAchse (LogikGrafikExtern, ArrayPositionExtern) := (Positive (ÄnderungEAchseExtern));
         ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (EAchseExtern);
         
         EAchseGrößerSchleife:
         while ZwischenwertEAchse (LogikGrafikExtern, ArrayPositionExtern) > 0 loop
            
            if
              ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) + 1 > Positive (Karten.WeltkarteArray'Last (1))
            then
               ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := Integer (Karten.WeltkarteArray'First (1));
               
            else
               ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern) + 1;
            end if;
            
            ZwischenwertEAchse (LogikGrafikExtern, ArrayPositionExtern) := ZwischenwertEAchse (LogikGrafikExtern, ArrayPositionExtern) - 1;
            
         end loop EAchseGrößerSchleife;
         
         return KartenDatentypen.EbeneVorhanden (ÜberhangEAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      else
         return EAchseExtern + ÄnderungEAchseExtern;
      end if;

   end PositionBestimmenEWechsel;
   
   
   
   -- Für die Y- und XAchse könnte eine Generic funktionieren. --------------------
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
         
         return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      elsif
        YAchseExtern + ÄnderungYAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (YAchseExtern + ÄnderungYAchseExtern - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         
         YAchseGrößerSchleife:
         while ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) loop
            
            ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
            
         end loop YAchseGrößerSchleife;
         
         return KartenDatentypen.KartenfeldPositiv (ÜberhangYAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;

   end PositionBestimmenYWechsel;
   
   
   
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
         
         return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      elsif
        XAchseExtern + ÄnderungXAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := Positive (XAchseExtern + ÄnderungXAchseExtern - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         
         XAchseGrößerSchleife:
         while ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) := ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         
         return KartenDatentypen.KartenfeldPositiv (ÜberhangXAchse (LogikGrafikExtern, ArrayPositionExtern));
               
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;

   end PositionBestimmenXWechsel;

end KartePositionGeraderUebergangBerechnungen;
