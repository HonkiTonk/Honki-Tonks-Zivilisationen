with RassenDatentypen;
with DatenbankRecords;

package RassenDatenbank is
   pragma Preelaborate;

   type RassenlisteArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of DatenbankRecords.RassenlisteRecord;
   Rassenliste : RassenlisteArray;
   
end RassenDatenbank;
