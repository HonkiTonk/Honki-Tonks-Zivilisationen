pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LeseKarten;

package body SchreibeKarten is

   procedure Grund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum)
   is begin
      
      if
        GrundExtern = KartenGrundDatentypen.Hügel_Enum
        and
          LeseKarten.Hügel (KoordinatenExtern => KoordinatenExtern) = True
      then
         Hügel (KoordinatenExtern => KoordinatenExtern,
                 HügelExtern       => False);
            
      else
         null;
      end if;
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Grund := GrundExtern;
      
   end Grund;
   
   
   
   procedure Hügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      HügelExtern : in Boolean)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Hügel := HügelExtern;
      
   end Hügel;
   
   
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern) := SichtbarExtern;
        
   end Sichtbar;
   
   
   
   procedure Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      FlussExtern : in KartenGrundDatentypen.Karten_Grund_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss := FlussExtern;
      
   end Fluss;
   
   
   
   procedure VerbesserungWeg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungWeg := WegExtern;
      
   end VerbesserungWeg;
   
   
   
   procedure VerbesserungGebiet
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).VerbesserungGebiet := VerbesserungExtern;
      
   end VerbesserungGebiet;
   
   
   
   procedure Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RessourceExtern : in KartenGrundDatentypen.Karten_Grund_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource := RessourceExtern;
      
   end Ressource;
   
   
   
   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldPositivRecord;
      BelegterGrundExtern : in KartenRecords.BelegterGrundRecord)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund := BelegterGrundExtern;
      
   end BelegterGrund;
   
   
   
   procedure Bewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in KartenDatentypen.GesamtbewertungFeld)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung (RasseExtern) := BewertungExtern;
      
   end Bewertung;

end SchreibeKarten;
