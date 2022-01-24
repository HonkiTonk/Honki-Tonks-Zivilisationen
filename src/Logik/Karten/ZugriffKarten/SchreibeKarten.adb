pragma SPARK_Mode (On);

with LeseKarten;

package body SchreibeKarten is

   procedure Grund
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
   is begin
      
      if
        GrundExtern = KartenDatentypen.Hügel
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
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      HügelExtern : in Boolean)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Hügel := HügelExtern;
      
   end Hügel;
   
   
   
   procedure Sichtbar
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Sichtbar (RasseExtern) := SichtbarExtern;
        
   end Sichtbar;
   
   
   
   procedure Fluss
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      FlussExtern : in KartenDatentypen.Karten_Grund_Enum)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss := FlussExtern;
      
   end Fluss;
   
   
   
   procedure VerbesserungWeg
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      WegExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungWeg := WegExtern;
      
   end VerbesserungWeg;
   
   
   
   procedure VerbesserungGebiet
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet := VerbesserungExtern;
      
   end VerbesserungGebiet;
   
   
   
   procedure Ressource
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource := RessourceExtern;
      
   end Ressource;
   
   
   
   procedure BelegterGrund
     (PositionExtern : KartenRecords.AchsenKartenfeldPositivRecord;
      BelegterGrundExtern : in KartenRecords.BelegterGrundRecord)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).DurchStadtBelegterGrund := BelegterGrundExtern;
      
   end BelegterGrund;
   
   
   
   procedure Bewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in KartenDatentypen.GesamtbewertungFeld)
   is begin
      
      Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Felderwertung (RasseExtern) := BewertungExtern;
      
   end Bewertung;

end SchreibeKarten;
