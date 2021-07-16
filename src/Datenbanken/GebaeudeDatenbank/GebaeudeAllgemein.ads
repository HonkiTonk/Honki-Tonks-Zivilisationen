pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package GebaeudeAllgemein is

   procedure Beschreibung
     (IDExtern : in GebäudeID);
   
   procedure GebäudeProduktionBeenden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GebäudeID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

end GebaeudeAllgemein;
