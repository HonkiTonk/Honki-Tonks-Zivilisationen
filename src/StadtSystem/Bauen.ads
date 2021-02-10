pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package Bauen is

   procedure Bauen (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => StadtRasseUndNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BauzeitEinzeln (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => StadtRasseUndNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BauzeitAlle;

private

   Taste : Wide_Wide_Character;

   WasGebautWerdenSoll : Integer;
   Ende : Integer;
   AktuelleAuswahl : Integer := 1;

   function AuswahlStadt (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) return Integer with
     Pre => StadtRasseUndNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

end Bauen;
