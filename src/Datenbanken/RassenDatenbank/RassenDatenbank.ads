pragma SPARK_Mode (On);

with GlobaleDatentypen;

with DatenbankRecords;

package RassenDatenbank is

   type RassenListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of DatenbankRecords.RassenListeRecord;
   RassenListe : RassenListeArray;
   
   procedure StandardRassenDatenbankLaden;

end RassenDatenbank;
