pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KIAufgabenErmittelnAllgemein is
   
   function SichHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
   function SichVerbessern
     return Natural;
   
   function NichtsTun
     return Natural;
   
private
   
   EinheitID : GlobaleDatentypen.EinheitenID;
   
end KIAufgabenErmittelnAllgemein;
