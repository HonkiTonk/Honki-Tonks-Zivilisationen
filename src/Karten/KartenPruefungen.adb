pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body KartenPruefungen is

   function KartenPositionBestimmen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      ZusatzYAbstandExtern : in GlobaleDatentypen.Kartenfeld)
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
         ÜberhangXAchse := Integer (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeKleiner:
         while ÜberhangXAchse < Integer (Karten.WeltkarteArray'First (3)) loop
            
            ÜberhangXAchse := ÜberhangXAchse + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop SchleifeKleiner;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse));
               
      elsif
        KoordinatenExtern.XAchse + ÄnderungExtern.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         ÜberhangXAchse := Positive (KoordinatenExtern.XAchse + ÄnderungExtern.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeGrößer:
         while ÜberhangXAchse > Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            ÜberhangXAchse := ÜberhangXAchse - Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop SchleifeGrößer;
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, GlobaleDatentypen.Kartenfeld (ÜberhangXAchse));
               
      else
         return (KoordinatenExtern.EAchse + ÄnderungExtern.EAchse, KoordinatenExtern.YAchse + ÄnderungExtern.YAchse, KoordinatenExtern.XAchse + ÄnderungExtern.XAchse);
      end if;
      
   end KartenPositionBestimmen;
   
   
   
   -- Sinnvoller benennen und weitere Prüfung für nur Wasser und so weiter einbauen
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
