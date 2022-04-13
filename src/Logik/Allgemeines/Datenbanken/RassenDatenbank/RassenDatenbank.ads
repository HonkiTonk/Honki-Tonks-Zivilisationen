pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

with DatenbankRecords;

package RassenDatenbank is

   type RassenListeArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of DatenbankRecords.RassenListeRecord;
   RassenListe : RassenListeArray;
   
   procedure StandardRassenDatenbankLaden;

end RassenDatenbank;
