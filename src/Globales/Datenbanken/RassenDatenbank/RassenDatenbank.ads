with RassenDatentypen;

with DatenbankRecords;

package RassenDatenbank is

   type RassenlisteArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of DatenbankRecords.RassenlisteRecord;
   Rassenliste : RassenlisteArray;
   
   procedure StandardRassenDatenbankLaden;

end RassenDatenbank;
