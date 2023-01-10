with SpeziesDatentypen;

private with EinheitenDatentypen;
private with StadtDatentypen;

with LeseSpeziesbelegung;

package KILogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure KI
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

private

   Städtezeitwert : StadtDatentypen.MaximaleStädteMitNullWert;

   Einheitenzeitwert : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   procedure EinheitenDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

   procedure StädteDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KILogik;
