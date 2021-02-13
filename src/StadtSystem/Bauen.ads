pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package Bauen is

   procedure Bauen (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BauzeitEinzeln (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BauzeitAlle;

private

   Taste : Wide_Wide_Character;

   WasGebautWerdenSoll : Integer;
   Ende : Integer;
   AktuelleAuswahl : Integer := 1;

   function AuswahlStadt (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) return Integer with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

end Bauen;
