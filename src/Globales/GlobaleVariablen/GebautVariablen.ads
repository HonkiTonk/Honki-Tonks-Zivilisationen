with RassenDatentypen;
with EinheitenDatentypen;
with EinheitenRecords;
with StadtDatentypen;
with StadtRecords;
with EinheitenRecordKonstanten;
with StadtRecordKonstanten;
with KartenRecordKonstanten;

package GebautVariablen is

   type EinheitenGebautArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitenDatentypen.MaximaleEinheiten'Range) of EinheitenRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
   
   type EinheitenBewegungsplanArray is array (EinheitenGebautArray'Range (1), EinheitenGebautArray'Range (2)) of EinheitenRecords.KIBewegungPlanArray;
   EinheitenBewegungsplan : EinheitenBewegungsplanArray := (others => (others => (others => KartenRecordKonstanten.LeerKoordinate)));
      
   type StadtGebautArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.MaximaleStädte'Range) of StadtRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => StadtRecordKonstanten.LeerStadt));

end GebautVariablen;
