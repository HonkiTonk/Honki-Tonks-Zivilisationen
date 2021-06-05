pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KINahkampfBodenAufgabeFestlegen is

   procedure NahkampfBodenAufgabeFestlegen
     (GewählteAufgabeExtern : in Natural;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

end KINahkampfBodenAufgabeFestlegen;
