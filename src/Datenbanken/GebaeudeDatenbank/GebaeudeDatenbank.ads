pragma SPARK_Mode (On);

with GlobaleDatentypen;

with DatenbankRecords;

package GebaeudeDatenbank is

   type GebäudeListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudeListeRecord;
   GebäudeListe : GebäudeListeArray;
   
   procedure StandardGebaeudeDatenbankLaden;
   
end GebaeudeDatenbank;
