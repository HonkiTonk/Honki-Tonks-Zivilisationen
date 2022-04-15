pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen;
with RassenDatentypen;

with DatenbankRecords;

package ForschungsDatenbank is

   type ForschungListeArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray;

   procedure StandardForschungsDatenbankLaden;

end ForschungsDatenbank;
