with SpeziesDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with KartenRecordKonstanten;

package KIVariablen is
   pragma Elaborate_Body;

   Kriegszustand : Boolean;

   type StadtverbindungArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, EinheitenDatentypen.Bewegungsplan'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtverbindung : StadtverbindungArray := (others => (others => KartenRecordKonstanten.LeerKoordinate));

end KIVariablen;
