pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package ZugriffEinheitenDatenbank is

   function EinheitenGrafik
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Wide_Wide_Character
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   
   function EinheitTyp
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.EinheitenTyp
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

end ZugriffEinheitenDatenbank;
