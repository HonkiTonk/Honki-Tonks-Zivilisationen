pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

package KennenLernen is

   procedure KennenLernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)      
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2));

end KennenLernen;
