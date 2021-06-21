pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body KartenPruefungen is

   -- Brauche ich das hier wirklich opder kann das mit einer kleinen Überarbeitung des Kartengenerators weg?
   function KartenPositionBestimmenKartengenerator
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin -- Der ZusatzYAbstandExtern ist für <=, also z. B. 1 für <= Karten.KartenArray'First (2) oder 4 für <= Karten.KartenArray'First (2) + 3
      
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
   
   
   
   -- Braucht für Karte/GrafischeAnzeige noch ein wenig Liebe oder Karte/GrafischeAnzeige braucht hierfür noch ein wenig Liebe.
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
         PositionXAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.XAchse;
      end if;
      
      if
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse < Karten.WeltkarteArray'First (2)
      then
         PositionYAchse (KoordinatenExtern.EAchse) := Karten.WeltkarteArray'First (2) - ÄnderungExtern.YAchse;
         if
           PositionXAchse (KoordinatenExtern.EAchse) + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            PositionXAchse (KoordinatenExtern.EAchse) := PositionXAchse (KoordinatenExtern.EAchse) - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PositionXAchse (KoordinatenExtern.EAchse) := PositionXAchse (KoordinatenExtern.EAchse) + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
               
      elsif
        KoordinatenExtern.YAchse + ÄnderungExtern.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         PositionYAchse (KoordinatenExtern.EAchse) := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ÄnderungExtern.YAchse;
         if
           PositionXAchse (KoordinatenExtern.EAchse) + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            PositionXAchse (KoordinatenExtern.EAchse) := PositionXAchse (KoordinatenExtern.EAchse) - KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         else
            PositionXAchse (KoordinatenExtern.EAchse) := PositionXAchse (KoordinatenExtern.EAchse) + KartenfeldPositiv (0.50 * Float (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         end if;
               
      else
         PositionYAchse (KoordinatenExtern.EAchse) := KoordinatenExtern.YAchse + ÄnderungExtern.YAchse;
      end if;

      if
        PositionXAchse (KoordinatenExtern.EAchse) + ÄnderungExtern.XAchse < Karten.WeltkarteArray'First (3)
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Integer (PositionXAchse (KoordinatenExtern.EAchse) + ÄnderungExtern.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseKleinerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) < Integer (Karten.WeltkarteArray'First (3)) loop
                                                                  
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop XAchseKleinerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, PositionYAchse (KoordinatenExtern.EAchse), GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      elsif
        PositionXAchse (KoordinatenExtern.EAchse) + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse (KoordinatenExtern.EAchse) := Positive (PositionXAchse (KoordinatenExtern.EAchse) + ÄnderungExtern.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         XAchseGrößerSchleife:
         while ÜberhangXAchse (KoordinatenExtern.EAchse) > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse (KoordinatenExtern.EAchse) := ÜberhangXAchse (KoordinatenExtern.EAchse) - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop XAchseGrößerSchleife;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, PositionYAchse (KoordinatenExtern.EAchse), GlobaleDatentypen.Kartenfeld (ÜberhangXAchse (KoordinatenExtern.EAchse)));
               
      else
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, PositionYAchse (KoordinatenExtern.EAchse), PositionXAchse (KoordinatenExtern.EAchse) + ÄnderungExtern.XAchse);
      end if;
      
   end KartenPositionBestimmen;
   
   
   
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
