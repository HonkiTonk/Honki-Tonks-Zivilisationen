pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with StadtDatentypen;
with SpielVariablen;
with StadtRecords;

private with KartenRecords;

package GebaeudeRichtigeUmgebung is

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function UmgebungPrüfen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end GebaeudeRichtigeUmgebung;
