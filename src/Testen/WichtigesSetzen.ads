pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package WichtigesSetzen is

   procedure GeldFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in Integer)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure ForschungsmengeFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in GlobaleDatentypen.KostenLager)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure ForschungsrateFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in GlobaleDatentypen.GesamtproduktionStadt)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure GeldZugewinnFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in GlobaleDatentypen.GesamtproduktionStadt)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

end WichtigesSetzen;
