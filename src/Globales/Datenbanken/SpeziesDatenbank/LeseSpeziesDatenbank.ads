with SpeziesDatentypen;
with SpielVariablen;
with StadtDatentypen;

package LeseSpeziesDatenbank is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function SpeziesAggressivität
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function SpeziesExpansion
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function SpeziesWissenschaft
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function SpeziesProduktion
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function SpeziesWirtschaft
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function SpeziesBewirtschaftung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function SpeziesGültigeStaatsform
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StaatsformExtern : SpeziesDatentypen.Staatsform_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseSpeziesDatenbank;
