pragma SPARK_Mode (On);

with GlobaleDatentypen;

with DatenbankRecords;

package EinheitenDatenbank is
  
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch, Planeteninneres
   
   type EinheitenListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.EinheitenID'Range) of DatenbankRecords.EinheitenListeRecord;
   EinheitenListe : EinheitenListeArray;
   
   procedure StandardEinheitenDatenbankLaden;

end EinheitenDatenbank;
