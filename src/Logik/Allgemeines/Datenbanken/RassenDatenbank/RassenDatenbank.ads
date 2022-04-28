pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;

with DatenbankRecords;

package RassenDatenbank is

   ------------------------ Hier weiter machen mit umbenennen.
   type RassenListeArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of DatenbankRecords.RassenListeRecord;
   RassenListe : RassenListeArray;
   
   procedure StandardRassenDatenbankLaden;

end RassenDatenbank;
