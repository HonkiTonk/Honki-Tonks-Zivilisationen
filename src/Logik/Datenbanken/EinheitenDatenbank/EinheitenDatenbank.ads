pragma SPARK_Mode (On);

with SystemDatentypen;
with EinheitStadtDatentypen;

with DatenbankRecords;

package EinheitenDatenbank is
     
   type EinheitenListeArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.EinheitenID'Range) of DatenbankRecords.EinheitenListeRecord;
   EinheitenListe : EinheitenListeArray;
   
   procedure StandardEinheitenDatenbankLaden;

end EinheitenDatenbank;
