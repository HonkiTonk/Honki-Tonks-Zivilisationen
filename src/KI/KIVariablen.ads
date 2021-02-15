pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;

package KIVariablen is

   type FeindlicheEinheitenArray is array (GlobaleVariablen.EinheitenGebautArray'Range (1), GlobaleVariablen.EinheitenGebautArray'Range (2),
                                           GlobaleDatentypen.LoopRangeMinusDreiZuDrei, GlobaleDatentypen.LoopRangeMinusDreiZuDrei) of GlobaleDatentypen.KartenverbesserungEinheitenID;
   FeindlicheEinheiten : FeindlicheEinheitenArray;

end KIVariablen;
