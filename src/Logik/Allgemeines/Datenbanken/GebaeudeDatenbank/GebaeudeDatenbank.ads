pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with StadtDatentypen;

with DatenbankRecords;

package GebaeudeDatenbank is

   type GebäudelisteArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudelisteRecord;
   GebäudeListe : GebäudelisteArray;
   
   procedure StandardGebaeudeDatenbankLaden;
   
end GebaeudeDatenbank;
