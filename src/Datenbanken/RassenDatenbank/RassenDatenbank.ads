pragma SPARK_Mode (On);

with GlobaleDatentypen, SonstigeDatentypen;

with DatenbankRecords;

package RassenDatenbank is

   type RassenListeArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of DatenbankRecords.RassenListeRecord;
   RassenListe : RassenListeArray;
   
   procedure StandardRassenDatenbankLaden;

end RassenDatenbank;
