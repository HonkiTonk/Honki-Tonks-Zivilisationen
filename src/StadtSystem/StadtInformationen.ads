pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package StadtInformationen is

   procedure StadtArtBesitzer
     (RasseExtern : in GlobaleDatentypen.Rassen;
      RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseUndPlatznummerExtern.Rasse) > 0
          and
            RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure StadtName
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

   procedure Einwohner
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

   procedure AktuelleNahrungsmittel
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

   procedure AktuelleNahrungsproduktion
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

   procedure AktuelleProduktionrate
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

   procedure AktuelleGeldgewinnung
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

   procedure AktuelleForschungsrate
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

   procedure Korruption
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

   procedure EinwohnerOhneArbeit
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

   procedure AktuellesBauprojekt
     (RasseUndPlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (RasseUndPlatznummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            RasseUndPlatznummerExtern.Platznummer > 0);

end StadtInformationen;
