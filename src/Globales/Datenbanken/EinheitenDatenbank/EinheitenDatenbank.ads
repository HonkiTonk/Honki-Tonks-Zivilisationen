with EinheitenDatentypen;
with RassenDatentypen;
with EinheitendatenbankRecord;

package EinheitenDatenbank is
     
   type EinheitenlisteArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitenDatentypen.EinheitenID'Range) of EinheitendatenbankRecord.EinheitenlisteRecord;
   Einheitenliste : EinheitenlisteArray;
   
   procedure StandardEinheitenDatenbankLaden;
   procedure EinheitenDatenbankSpeichern;

end EinheitenDatenbank;
