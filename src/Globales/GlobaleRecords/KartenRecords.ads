pragma SPARK_Mode (On);

with GlobaleDatentypen;

package KartenRecords is

   type AchsenStadtfeldRecord is record
      
      YAchse : GlobaleDatentypen.Stadtfeld;
      XAchse : GlobaleDatentypen.Stadtfeld;
      
   end record;
   
   
   
   type AchsenKartenfeldPositivRecord is tagged record
      
      EAchse : GlobaleDatentypen.EbeneVorhanden;
      YAchse : GlobaleDatentypen.KartenfeldPositivMitNullwert;
      XAchse : GlobaleDatentypen.KartenfeldPositivMitNullwert;
      
   end record;
   
   

   type AchsenKartenfeldRecord is record
      
      EAchse : GlobaleDatentypen.Ebene;
      YAchse : GlobaleDatentypen.Kartenfeld;
      XAchse : GlobaleDatentypen.Kartenfeld;
      
   end record;
   
   
   
   -- Die Bewertung rauswerfen und entsprechend die Einheiten beim Bauen einer Stadt alles Bewerten lassen?
   -- Felderbelegung stattdessen einbauen?
   type FelderwertungArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleDatentypen.GesamtproduktionStadt;
   
   type KartenRecord is record

      Grund : GlobaleDatentypen.Karten_Grund_Enum;
      Hügel : Boolean;
      Sichtbar : GlobaleDatentypen.SichtbarkeitArray;
      
      Fluss : GlobaleDatentypen.Karten_Grund_Enum;
      VerbesserungWeg : GlobaleDatentypen.Karten_Verbesserung_Enum;
      VerbesserungGebiet : GlobaleDatentypen.Karten_Verbesserung_Enum;
      Ressource : GlobaleDatentypen.Karten_Grund_Enum;
      
      DurchStadtBelegterGrund : GlobaleDatentypen.BelegterGrund;
      Felderwertung : FelderwertungArray;

   end record;
   
   
   
   type CursorRecord is record
      
      CursorGrafik : Wide_Wide_Character;
      Position : AchsenKartenfeldPositivRecord;
      PositionAlt : AchsenKartenfeldPositivRecord;
      PositionStadt : AchsenStadtfeldRecord;
      
   end record;

end KartenRecords;
