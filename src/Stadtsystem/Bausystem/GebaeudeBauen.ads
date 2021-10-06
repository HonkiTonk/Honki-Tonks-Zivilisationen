pragma SPARK_Mode (On);

with EinheitStadtRecords;
with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;

package GebaeudeBauen is

   procedure AnzeigeGebäude
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);
   
private
   
   PermanenteGebäudeWerte : Boolean;
   
   procedure PermanenteKostenGebäude
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure PreisGebäude
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure BauzeitGebäude
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end GebaeudeBauen;
