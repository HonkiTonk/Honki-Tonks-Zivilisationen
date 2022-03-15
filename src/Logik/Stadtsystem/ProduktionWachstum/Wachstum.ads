pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with SystemKonstanten;

package Wachstum is
   
   procedure StadtWachstum;
   
   procedure WachstumWichtiges
     (RasseExtern : in SystemDatentypen.Rassen_Enum);
   
private
   
   WachstumSchrumpfung : Boolean;
   
   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);

   procedure WachstumProduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   procedure WachstumsratenBerechnen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   procedure EinwohnerÄnderung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure NeuerEinwohner
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end Wachstum;
