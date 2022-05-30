pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with LeseKarten;

package body SchreibeKarten is

   procedure AktuellerGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).AktuellerGrund := GrundExtern;
      
   end AktuellerGrund;
   
   
   
   procedure BasisGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Enum)
   is begin
            
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).BasisGrund := GrundExtern;
      
   end BasisGrund;
   
   
   
   procedure ZweimalGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).AktuellerGrund := GrundExtern;
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).BasisGrund := GrundExtern;
      
   end ZweimalGrund;
   
   
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern) := SichtbarExtern;
        
   end Sichtbar;
   
   
   
   procedure Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Fluss := FlussExtern;
      
   end Fluss;
   
   
   
   procedure Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Weg := WegExtern;
      
   end Weg;
   
   
   
   procedure Verbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Verbesserung := VerbesserungExtern;
      
   end Verbesserung;
   
   
   
   procedure Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Enum)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Ressource := RessourceExtern;
      
   end Ressource;
   
   
   
   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegterGrundExtern : in KartenRecords.BelegterGrundRecord)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund := BelegterGrundExtern;
      
   end BelegterGrund;
   
   
   
   procedure Bewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in KartenDatentypen.GesamtbewertungFeld)
   is begin
      
      Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung (RasseExtern) := BewertungExtern;
      
   end Bewertung;

end SchreibeKarten;
