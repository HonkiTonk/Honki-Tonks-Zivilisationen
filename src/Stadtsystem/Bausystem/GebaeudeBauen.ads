pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package GebaeudeBauen is

   procedure AnzeigeGebäude
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);
   
private
   
   PermanenteGebäudeWerte : Boolean;
   
   procedure PermanenteKostenGebäude
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);

   procedure PreisGebäude
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure BauzeitGebäude
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

end GebaeudeBauen;
