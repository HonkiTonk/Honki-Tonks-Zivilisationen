with SpeziesDatentypen;
with DatenbankRecords;

package SpeziesDatenbank is
   pragma Preelaborate;

   type SpezieslisteArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of DatenbankRecords.SpezieslisteRecord;
   Speziesliste : SpezieslisteArray;
   
end SpeziesDatenbank;
