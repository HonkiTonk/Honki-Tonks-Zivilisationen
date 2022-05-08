pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitStadtRecords;
with SonstigeVariablen;

package Wachstum is
   
   procedure StadtWachstum;
   
   procedure WachstumWichtiges
     (RasseExtern : in RassenDatentypen.Rassen_Enum);
   
private
   
   WachstumSchrumpfung : Boolean;
   
   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure WachstumProduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure WachstumsratenBerechnen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure EinwohnerÄnderung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure NeuerEinwohner
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);

end Wachstum;
