pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen;
with RassenDatentypen;

with DatenbankRecords;

package ForschungenDatenbank is

   type ForschungslisteArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, ForschungenDatentypen.ForschungID'Range) of DatenbankRecords.ForschungslisteRecord;
   Forschungsliste : ForschungslisteArray;

   procedure StandardForschungenDatenbankLaden;

end ForschungenDatenbank;
