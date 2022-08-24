pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;
with RassenDatentypen;

with DatenbankRecords;

package EinheitenDatenbank is
     
   type EinheitenlisteArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitenDatentypen.EinheitenID'Range) of DatenbankRecords.EinheitenlisteRecord;
   Einheitenliste : EinheitenlisteArray;
   
   procedure StandardEinheitenDatenbankLaden;

end EinheitenDatenbank;
