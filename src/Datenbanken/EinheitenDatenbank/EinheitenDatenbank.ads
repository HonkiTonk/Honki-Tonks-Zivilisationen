pragma SPARK_Mode (On);

with GlobaleDatentypen, SonstigeDatentypen, EinheitStadtDatentypen;

with DatenbankRecords;

package EinheitenDatenbank is
  
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch, Planeteninneres
   
   type EinheitenListeArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.EinheitenID'Range) of DatenbankRecords.EinheitenListeRecord;
   EinheitenListe : EinheitenListeArray;
   
   procedure StandardEinheitenDatenbankLaden;

end EinheitenDatenbank;
