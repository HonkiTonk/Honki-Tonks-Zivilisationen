pragma SPARK_Mode (On);

with GlobaleDatentypen;

with DatenbankRecords;

package ForschungsDatenbank is

   type ForschungListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray;

   procedure StandardForschungsDatenbankLaden;

end ForschungsDatenbank;
