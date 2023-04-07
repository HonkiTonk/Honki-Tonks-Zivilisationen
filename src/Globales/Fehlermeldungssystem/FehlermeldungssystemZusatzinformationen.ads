with Sf.System.Vector2;

with KartenRecords;
with SpeziesDatentypen;
with EinheitenDatentypen;

package FehlermeldungssystemZusatzinformationen is
   pragma Elaborate_Body;

   function Koordinaten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Wide_Wide_String
     with
       Post => (
                  Koordinaten'Result'Length > 0
               );

   function SpeziesID
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Wide_Wide_String
     with
       Post => (
                  SpeziesID'Result'Length > 0
               );

   function Floatvektor
     (VektorExtern : in Sf.System.Vector2.sfVector2f)
      return Wide_Wide_String
     with
       Post => (
                  Floatvektor'Result'Length > 0
               );

end FehlermeldungssystemZusatzinformationen;
