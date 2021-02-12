pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package Sortieren is

   procedure EinheitenSortieren (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure StädteSortieren (RasseExtern : in GlobaleDatentypen.Rassen);

private
   
   type SortierenEinheitenArray is array (GlobaleVariablen.EinheitenGebautArray'Range (2)) of GlobaleRecords.EinheitenGebautRecord;
   SortierenEinheiten : SortierenEinheitenArray;

   type SortierenStädteArray is array (GlobaleVariablen.StadtGebautArray'Range (2)) of GlobaleRecords.StadtGebautRecord;
   SortierenStädte : SortierenStädteArray;

end Sortieren;
