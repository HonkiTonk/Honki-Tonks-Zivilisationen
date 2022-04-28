pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with EinheitStadtDatentypen;

with DatenbankRecords;

package GebaeudeDatenbank is

   type GebäudelisteArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.GebäudeID'Range) of DatenbankRecords.GebäudelisteRecord;
   GebäudeListe : GebäudelisteArray;
   
   procedure StandardGebaeudeDatenbankLaden;
   
end GebaeudeDatenbank;
