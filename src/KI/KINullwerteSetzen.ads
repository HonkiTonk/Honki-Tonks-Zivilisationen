pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

package KINullwerteSetzen is

   procedure ZielBewegungNullSetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelchenWertNullSetzenExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

end KINullwerteSetzen;
