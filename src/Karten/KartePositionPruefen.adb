pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body KartePositionPruefen is
   
   function KartenPositionBestimmen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      -- Der ZusatzYAbstandExtern ist für <=, also z. B. 1 für <= Karten.KartenArray'First (2) oder 4 für <= Karten.KartenArray'First (2) + 3
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      -- Zustandabstand rauswerfen? Wird ja eh nur im Kartengenerator verwendet oder?
      -- 1 = X-Zylinder, 2 = Y-Zylinder, 3 = Torus, 4 = Kugel, 5 = Viereck
      case
        Karten.Kartenform
      is
         when 1 =>
            return KartenPositionXZylinder (KoordinatenExtern    => KoordinatenExtern,
                                            ÄnderungExtern       => ÄnderungExtern,
                                            ZusatzYAbstandExtern => ZusatzYAbstandExtern);
            
         when 2 =>
            return KartenPositionYZylinder (KoordinatenExtern    => KoordinatenExtern,
                                            ÄnderungExtern       => ÄnderungExtern);
            
         when 3 =>
            return KartenPositionTorus (KoordinatenExtern    => KoordinatenExtern,
                                        ÄnderungExtern       => ÄnderungExtern,
                                        ZusatzYAbstandExtern => ZusatzYAbstandExtern);
            
         when 4 =>
            return KartenPositionKugel (KoordinatenExtern    => KoordinatenExtern,
                                        ÄnderungExtern       => ÄnderungExtern,
                                        ZusatzYAbstandExtern => ZusatzYAbstandExtern);
            
         when 5 =>
            return KartenPositionViereck (KoordinatenExtern    => KoordinatenExtern,
                                          ÄnderungExtern       => ÄnderungExtern,
                                          ZusatzYAbstandExtern => ZusatzYAbstandExtern);
      end case;
      -- 1 = X-Zylinder, 2 = Y-Zylinder, 3 = Torus, 4 = Kugel, 5 = Viereck
      
   end KartenPositionBestimmen;
   
   
   
   function KartenPositionXZylinder
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.EAchse + ÄnderungExtern.EAchse < Karten.WeltkarteArray'First (1)
        or
          KoordinatenExtern.EAchse + ÄnderungExtern.EAchse > Karten.WeltkarteArray'Last (1)
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2) + ZusatzYAbstandExtern
        or
          KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ZusatzYAbstandExtern
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      else
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end KartenPositionXZylinder;
   
   
   
   function KartenPositionYZylinder
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.EAchse + ÄnderungExtern.EAchse < Karten.WeltkarteArray'First (1)
        or
          KoordinatenExtern.EAchse + ÄnderungExtern.EAchse > Karten.WeltkarteArray'Last (1)
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
        or
          KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2)
      then
         ÜberhangYAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseKleinerSchleife:
         while ÜberhangYAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (2)) loop
            
            ÜberhangYAchse (KoordinatenExtern.EAchse) := ÜberhangYAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);

         end loop YAchseKleinerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (KoordinatenExtern.EAchse)), KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
               
      elsif
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         ÜberhangYAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseGrößerSchleife:
         while ÜberhangYAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) loop
            
            ÜberhangYAchse (KoordinatenExtern.EAchse) := ÜberhangYAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
            
         end loop YAchseGrößerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (KoordinatenExtern.EAchse)), KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
               
      else
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end KartenPositionYZylinder;
   
   
   
   function KartenPositionTorus
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.EAchse + ÄnderungExtern.EAchse < Karten.WeltkarteArray'First (1)
        or
          KoordinatenExtern.EAchse + ÄnderungExtern.EAchse > Karten.WeltkarteArray'Last (1)
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2) + ZusatzYAbstandExtern
        or
          KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ZusatzYAbstandExtern
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      else
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end KartenPositionTorus;
   
   
   
   function KartenPositionKugel
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.EAchse + ÄnderungExtern.EAchse < Karten.WeltkarteArray'First (1)
        or
          KoordinatenExtern.EAchse + ÄnderungExtern.EAchse > Karten.WeltkarteArray'Last (1)
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2) + ZusatzYAbstandExtern
        or
          KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ZusatzYAbstandExtern
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      else
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end KartenPositionKugel;
   
   
   
   function KartenPositionViereck
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.EAchse + ÄnderungExtern.EAchse < Karten.WeltkarteArray'First (1)
        or
          KoordinatenExtern.EAchse + ÄnderungExtern.EAchse > Karten.WeltkarteArray'Last (1)
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2) + ZusatzYAbstandExtern
        or
          KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ZusatzYAbstandExtern
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;

      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
        or
          KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end KartenPositionViereck;
   
   
   
   function KartenPositionBestimmena
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.EAchse + ÄnderungExtern.EAchse < Karten.WeltkarteArray'First (1)
        or
          KoordinatenExtern.EAchse + ÄnderungExtern.EAchse > Karten.WeltkarteArray'Last (1)
      then
         return GlobaleKonstanten.RückgabeKartenPositionFalsch;
         
      else
         null;
      end if;
      
      PositionAchse (KoordinatenExtern.EAchse) := KartenPositionBestimmenYAchse (KoordinatenExtern => KoordinatenExtern,
                                                                                 ÄnderungExtern   => ÄnderungExtern);
      
      PositionAchse (KoordinatenExtern.EAchse) := KartenPositionBestimmenXAchse (KoordinatenExtern => (0, PositionAchse (KoordinatenExtern.EAchse).YAchse, PositionAchse (KoordinatenExtern.EAchse).XAchse),
                                                                                 ÄnderungExtern   => ÄnderungExtern);

      PositionAchse (KoordinatenExtern.EAchse).EAchse := KoordinatenExtern.EAchse + ÄnderungExtern.EAchse;

      return PositionAchse (KoordinatenExtern.EAchse);
      
   end KartenPositionBestimmena;
   
   
   
   function KartenPositionBestimmenYAchse
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
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
                      
         ÜberhangYAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseKleinerSchleife:
         while ÜberhangYAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (2)) loop
                                                                  
            ÜberhangYAchse (KoordinatenExtern.EAchse) := ÜberhangYAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);

         end loop YAchseKleinerSchleife;
         return (0, GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (KoordinatenExtern.EAchse)), PolXAchse (KoordinatenExtern.EAchse));
               
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
         
         ÜberhangYAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.YAchse + ÄnderungExtern.YAchse - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
         YAchseGrößerSchleife:
         while ÜberhangYAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) loop
            
            ÜberhangYAchse (KoordinatenExtern.EAchse) := ÜberhangYAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße);
            
         end loop YAchseGrößerSchleife;
         return (0, GlobaleDatentypen.Kartenfeld (ÜberhangYAchse (KoordinatenExtern.EAchse)), PolXAchse (KoordinatenExtern.EAchse));
               
      else
         return (0, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse);
      end if;
      
   end KartenPositionBestimmenYAchse;
   
   
   
   function KartenPositionBestimmenXAchse
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Integer (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (3)) loop
                                                                  
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return (0, KoordinatenExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Positive (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return (0, KoordinatenExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      else
         return (0, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end KartenPositionBestimmenXAchse;
   
end KartePositionPruefen;
