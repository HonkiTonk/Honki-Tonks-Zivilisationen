with SpeziesDatentypen;
with SpeziesdatenbankRecord;

package SpeziesDatenbank is
   pragma Preelaborate;

   type SpezieslisteArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of SpeziesdatenbankRecord.SpezieslisteRecord;
   Speziesliste : SpezieslisteArray;
   
end SpeziesDatenbank;
