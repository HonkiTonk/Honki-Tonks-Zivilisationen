pragma SPARK_Mode (On);

with GlobaleDatentypen, EinheitStadtDatentypen, SonstigeDatentypen;

with DatenbankRecords;

package ForschungsDatenbank is

   type ForschungListeArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray;

   procedure StandardForschungsDatenbankLaden;

end ForschungsDatenbank;
