pragma SPARK_Mode (On);

with SonstigeDatentypen;
with EinheitStadtDatentypen;

with DatenbankRecords;

package GebaeudeDatenbank is

   type GebäudeListeArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudeListeRecord;
   GebäudeListe : GebäudeListeArray;
   
   procedure StandardGebaeudeDatenbankLaden;
   
end GebaeudeDatenbank;
