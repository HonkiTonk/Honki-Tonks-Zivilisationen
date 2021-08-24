pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KIAufgabenErmittelnAllgemein is
   
   function SichHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
   function SichVerbessern
     return GlobaleDatentypen.GesamtproduktionStadt;
   
   function NichtsTun
     return GlobaleDatentypen.GesamtproduktionStadt;
   
private
   
   EinheitID : GlobaleDatentypen.EinheitenID;
   
end KIAufgabenErmittelnAllgemein;
