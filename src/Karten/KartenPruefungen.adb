pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body KartenPruefungen is

   -- Brauche ich das hier wirklich opder kann das mit einer kleinen Überarbeitung des Kartengenerators weg?
   function KartenPositionBestimmenKartengenerator
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      -- Der ZusatzYAbstandExtern ist für <=, also z. B. 1 für <= Karten.KartenArray'First (2) oder 4 für <= Karten.KartenArray'First (2) + 3
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
      
   end KartenPositionBestimmenKartengenerator;
   
   
   
   function KartenPositionBestimmen
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
      
   end KartenPositionBestimmen;
   
   
   
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
   
   
   
   -- Entfernen und entweder durch irgendwas im Bewegungssystem ersetzen oder über Zugriff auf die EinheitenDatenbank die Passierbarkeit prüfen
   function KartenGrund
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund
      is
         when 1 .. 2 | 29 .. 31 | 36 =>
            return False;
            
         when others =>
            return True;
      end case;
      
   end KartenGrund;

end KartenPruefungen;
