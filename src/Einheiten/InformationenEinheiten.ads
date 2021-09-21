pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package InformationenEinheiten is

   procedure Einheiten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
private
   
   ErsteAnzeige : Boolean;
   
   IDEinheit : GlobaleDatentypen.EinheitenID;
   
   EinheitNummer : GlobaleDatentypen.MaximaleEinheiten;
   
   EinheitRasseNummer : GlobaleRecords.RassePlatznummerRecord;
   
   function Allgemeines
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.RassePlatznummerRecord;
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Angriff
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Verteidigung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Rang
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure AktuelleVerteidigung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure AktuellerAngriff
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Ladung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure Gecheatet
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

end InformationenEinheiten;
