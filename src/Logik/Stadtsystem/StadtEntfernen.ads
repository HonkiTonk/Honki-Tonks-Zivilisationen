pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with KartenRecords;
with SonstigeVariablen;

package StadtEntfernen is

   procedure StadtEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure HeimatstädteEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure NeueHauptstadtSetzen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);

end StadtEntfernen;
