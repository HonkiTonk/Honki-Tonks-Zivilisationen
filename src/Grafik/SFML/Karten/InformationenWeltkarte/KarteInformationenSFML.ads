pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with EinheitenRecords;
private with StadtRecords;
private with KartenRecords;

package KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   StadtVorhanden : Boolean;

   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;

   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KarteInformationenSFML;
