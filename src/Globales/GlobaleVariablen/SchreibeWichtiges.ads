pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package SchreibeWichtiges is

   procedure Geldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in Integer;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure GeldZugewinnProRunde
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in GlobaleDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure GesamteForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in GlobaleDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure Forschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in GlobaleDatentypen.KostenLager;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure VerbleibendeForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   procedure Forschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in GlobaleDatentypen.ForschungIDMitNullWert)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   procedure Erforscht
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in GlobaleDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

end SchreibeWichtiges;
