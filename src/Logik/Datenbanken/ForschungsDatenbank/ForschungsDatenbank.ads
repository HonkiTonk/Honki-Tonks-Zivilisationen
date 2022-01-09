pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
with SystemDatentypen;

with DatenbankRecords;

package ForschungsDatenbank is

   type ForschungListeArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray;

   procedure StandardForschungsDatenbankLaden;

end ForschungsDatenbank;
