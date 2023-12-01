with SpeziesDatentypen;
with EinheitenDatentypen;
with EinheitenRecords;
with StadtDatentypen;
with StadtRecords;
with EinheitenRecordKonstanten;
with StadtRecordKonstanten;
with KartenRecordKonstanten;

package GebautVariablen is
   pragma Elaborate_Body;

   type EinheitenGebautArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, EinheitenDatentypen.EinheitenbereichVorhanden'Range) of EinheitenRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
   
   type EinheitenBewegungsplanArray is array (EinheitenGebautArray'Range (1), EinheitenGebautArray'Range (2)) of EinheitenRecords.KIBewegungPlanArray;
   EinheitenBewegungsplan : EinheitenBewegungsplanArray := (others => (others => (others => KartenRecordKonstanten.LeerKoordinate)));
      
   type StadtGebautArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, StadtDatentypen.StädtebereichVorhanden'Range) of StadtRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => StadtRecordKonstanten.LeerStadt));

end GebautVariablen;
