with EinheitenRecords;
with KartenRecords;
with EinheitenDatentypen;

package EinheitenGrafikRecords is
   pragma Pure;
   
   type EinheitGrafikRecord is record
      
      SpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;
      
      ID : EinheitenDatentypen.EinheitenIDMitNullWert;
      Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      
   end record;

end EinheitenGrafikRecords;
