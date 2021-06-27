pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package ZugriffGebaeudeDatenbank is
   
   -- Mit ID
   function GrafikMitID
     (RasseExtern : in GlobaleDatentypen.Rassen;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return Wide_Wide_Character
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   -- Mit ID

end ZugriffGebaeudeDatenbank;
