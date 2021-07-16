pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

package KINullwerteSetzen is

   procedure ZielBewegungNullSetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelchenWertNullSetzten : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

end KINullwerteSetzen;
