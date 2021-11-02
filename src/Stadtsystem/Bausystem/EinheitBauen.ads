pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;

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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure MaximaleBewegungspunkte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure MaximaleLebenspunkte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure Verteidigung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure Angriff
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure Preis
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure BauzeitEinheit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end EinheitBauen;
