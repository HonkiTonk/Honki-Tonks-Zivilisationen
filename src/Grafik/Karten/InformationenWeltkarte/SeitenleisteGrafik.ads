pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
-- with SpielVariablen;

private with EinheitenRecords;
private with StadtRecords;
private with KartenRecords;

package SeitenleisteGrafik is

   procedure SeitenleisteGrafik
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

private

   StadtVorhanden : Boolean;

   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;

   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end SeitenleisteGrafik;
