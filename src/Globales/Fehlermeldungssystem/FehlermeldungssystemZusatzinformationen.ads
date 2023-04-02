with KartenRecords;
with SpeziesDatentypen;
with EinheitenDatentypen;

package FehlermeldungssystemZusatzinformationen is
   pragma Pure;

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

end FehlermeldungssystemZusatzinformationen;
