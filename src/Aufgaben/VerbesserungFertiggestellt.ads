pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package VerbesserungFertiggestellt is

   procedure VerbesserungFertiggestellt;
   
private
   
   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure VerbesserungWaldAufforsten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure AufgabeNachfolgerVerschieben
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

end VerbesserungFertiggestellt;
