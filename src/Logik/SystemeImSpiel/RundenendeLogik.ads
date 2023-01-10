private with SpeziesDatentypen;

private with LeseSpeziesbelegung;

package RundenendeLogik is
   pragma Elaborate_Body;

   function BerechnungenRundenende
     return Boolean;

private
   use type SpeziesDatentypen.Spieler_Enum;

   Weiterspielen : Boolean;

   procedure GeldForschungDiplomatieÄndern;

   procedure GeldForschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure Diplomatie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );



   function NachSiegWeiterspielen
     return Boolean;

end RundenendeLogik;
