pragma SPARK_Mode (On);

package body LeseForschungsDatenbank is

   function PreisForschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.ForschungID)
      return GlobaleDatentypen.KostenLager;

   function AnforderungForschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.ForschungID)
      return GlobaleDatentypen.AnforderungForschungArray;

end LeseForschungsDatenbank;
