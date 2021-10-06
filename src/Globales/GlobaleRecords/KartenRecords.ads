pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
with KartenDatentypen;
with SonstigeDatentypen;

package KartenRecords is

   type AchsenStadtfeldRecord is record
      
      YAchse : KartenDatentypen.Stadtfeld;
      XAchse : KartenDatentypen.Stadtfeld;
      
   end record;
   
   
   
   type AchsenKartenfeldPositivRecord is tagged record
      
      EAchse : KartenDatentypen.EbeneVorhanden;
      YAchse : KartenDatentypen.KartenfeldPositivMitNullwert;
      XAchse : KartenDatentypen.KartenfeldPositivMitNullwert;
      
   end record;
   
   

   type AchsenKartenfeldRecord is record
      
      EAchse : KartenDatentypen.Ebene;
      YAchse : KartenDatentypen.Kartenfeld;
      XAchse : KartenDatentypen.Kartenfeld;
      
   end record;
   
   
   
   -- Die Bewertung rauswerfen und entsprechend die Einheiten beim Bauen einer Stadt alles Bewerten lassen?
   -- Felderbelegung stattdessen einbauen?
   type FelderwertungArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.GesamtproduktionStadt;
   
   type KartenRecord is record

      Grund : KartenDatentypen.Karten_Grund_Enum;
      Hügel : Boolean;
      Sichtbar : KartenDatentypen.SichtbarkeitArray;
      
      Fluss : KartenDatentypen.Karten_Grund_Enum;
      VerbesserungWeg : KartenDatentypen.Karten_Verbesserung_Enum;
      VerbesserungGebiet : KartenDatentypen.Karten_Verbesserung_Enum;
      Ressource : KartenDatentypen.Karten_Grund_Enum;
      
      DurchStadtBelegterGrund : KartenDatentypen.BelegterGrund;
      Felderwertung : FelderwertungArray;

   end record;
   
   
   
   type CursorRecord is record
      
      CursorGrafik : Wide_Wide_Character;
      Position : AchsenKartenfeldPositivRecord;
      PositionAlt : AchsenKartenfeldPositivRecord;
      PositionStadt : AchsenStadtfeldRecord;
      
   end record;

end KartenRecords;
