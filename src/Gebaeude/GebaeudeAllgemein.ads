pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package GebaeudeAllgemein is

   procedure BeschreibungKurz
     (IDExtern : in GlobaleDatentypen.GebäudeIDMitNullwert);
   
   procedure BeschreibungLang
     (IDExtern : in GlobaleDatentypen.GebäudeIDMitNullwert);
   
   procedure GebäudeProduktionBeenden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in GlobaleDatentypen.GebäudeID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function GebäudeAnforderungenErfüllt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
   
   procedure PermanenteKostenDurchGebäudeÄndern
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.GebäudeID;
      VorzeichenWechselExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (VorzeichenWechselExtern /= 0);

end GebaeudeAllgemein;
