pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;

package EinheitBauen is

   procedure AnzeigeEinheiten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);
   
private
   
   PermanenteEinheitenWerte : Boolean;
   
   procedure PermanenteKostenEinheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure MaximaleBewegungspunkte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure MaximaleLebenspunkte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure Verteidigung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure Angriff
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure Preis
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure BauzeitEinheit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end EinheitBauen;
