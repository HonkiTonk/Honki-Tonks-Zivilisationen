with EinheitenDatentypen;
with SpeziesDatentypen;
with EinheitendatenbankRecord;

package EinheitenDatenbank is
   pragma Preelaborate;
     
   type EinheitenlisteArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, EinheitenDatentypen.EinheitenID'Range) of EinheitendatenbankRecord.EinheitenlisteRecord;
   Einheitenliste : EinheitenlisteArray;
   
end EinheitenDatenbank;
