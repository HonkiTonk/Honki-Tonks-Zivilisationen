pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package EinheitBauen is

   procedure AnzeigeEinheiten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);
   
private
   
   PermanenteEinheitenWerte : Boolean;
   
   procedure PermanenteKostenEinheiten
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure MaximaleBewegungspunkte
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure MaximaleLebenspunkte
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure Verteidigung
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure Angriff
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure Preis
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure BauzeitEinheit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end EinheitBauen;
