pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package ZugriffForschungsDatenbank is

   -- Ohne ID
   function PreisOhneID
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   -- Ohne ID
   
   -- Mit ID
   
   -- Mit ID

end ZugriffForschungsDatenbank;
