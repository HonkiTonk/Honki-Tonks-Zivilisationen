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
   function PreisMitID
     (RasseExtern : in GlobaleDatentypen.Rassen;
      IDExtern : in GlobaleDatentypen.ForschungID)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   function AnforderungMitID
     (RasseExtern : in GlobaleDatentypen.Rassen;
      IDExtern : in GlobaleDatentypen.ForschungID;
      ArrayPositionExtern : in Positive)
      return ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   -- Mit ID

end ZugriffForschungsDatenbank;
