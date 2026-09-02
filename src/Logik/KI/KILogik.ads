with SpeziesDatentypen;

private with EinheitenDatentypen;
private with StadtDatentypen;

with LeseSpeziesbelegung;

package KILogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure KI
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

private

   StädteVorhanden : StadtDatentypen.StädtebereichBasis;

   Anfangseinheiten : EinheitenDatentypen.EinheitenbereichBasis;
   AktuelleEinheiten : EinheitenDatentypen.EinheitenbereichBasis;
   LetzteEinheit : EinheitenDatentypen.EinheitenbereichBasis;

   LadezeitBasis : Float;

   procedure EinheitenDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

   procedure StädteDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KILogik;
