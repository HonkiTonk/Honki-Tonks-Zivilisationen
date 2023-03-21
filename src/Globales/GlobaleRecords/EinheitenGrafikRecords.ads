with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with EinheitenRecords;
with KartenRecords;
with EinheitenDatentypen;
with SpeziesDatentypen;

package EinheitenGrafikRecords is
   pragma Preelaborate;
   
   type EinheitGrafikRecord is record
      
      SpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;
      
      ID : EinheitenDatentypen.EinheitenIDMitNullWert;
      Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      
   end record;
   
   
   
   type SpeziesStadtnameGrafikRecord is record
      
      Spezies : SpeziesDatentypen.Spezies_Enum;
      
      Stadtname : Unbounded_Wide_Wide_String;
      
   end record;

end EinheitenGrafikRecords;
