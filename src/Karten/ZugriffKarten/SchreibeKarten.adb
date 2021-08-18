pragma SPARK_Mode (On);

with LeseKarten;

package body SchreibeKarten is

   procedure Grund
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin
      
      if
        GrundExtern = GlobaleDatentypen.Hügel
        and
          LeseKarten.Hügel (PositionExtern => PositionExtern) = True
      then
         Hügel (PositionExtern => PositionExtern,
                 HügelExtern   => False);
            
      else
         null;
      end if;
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund := GrundExtern;
      
   end Grund;
   
   
   
   procedure Hügel
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      HügelExtern : in Boolean)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Hügel := HügelExtern;
      
   end Hügel;
   
   
   
   procedure Sichtbar
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Sichtbar (RasseExtern) := SichtbarExtern;
        
   end Sichtbar;
   
   
   
   procedure Fluss
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      FlussExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss := FlussExtern;
      
   end Fluss;
   
   
   
   procedure VerbesserungWeg
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      WegExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungWeg := WegExtern;
      
   end VerbesserungWeg;
   
   
   
   procedure VerbesserungGebiet
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet := VerbesserungExtern;
      
   end VerbesserungGebiet;
   
   
   
   procedure Ressource
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RessourceExtern : in GlobaleDatentypen.Karten_Grund_Enum)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource := RessourceExtern;
      
   end Ressource;
   
   
   
   procedure BelegterGrund
     (PositionExtern : GlobaleRecords.AchsenKartenfeldPositivRecord;
      BelegterGrundExtern : in GlobaleDatentypen.BelegterGrund)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).DurchStadtBelegterGrund := BelegterGrundExtern;
      
   end BelegterGrund;
   
   
   
   procedure Bewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Felderwertung (RasseExtern) := BewertungExtern;
      
   end Bewertung;

end SchreibeKarten;
