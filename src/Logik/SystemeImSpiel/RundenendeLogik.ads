private with SpeziesDatentypen;
private with SpielDatentypen;
private with DiplomatieDatentypen;

private with LeseSpeziesbelegung;

package RundenendeLogik is
   pragma Elaborate_Body;

   function BerechnungenRundenende
     return Boolean;

private
   use type SpeziesDatentypen.Spieler_Enum;

   Weiterspielen : Boolean;

   type SchwierigkeitsgradArray is array (SpielDatentypen.Schwierigkeitsgrad_Enum'Range) of DiplomatieDatentypen.MeinungPositive;
   SchwierigkeitsgradMeinungsverbesserung : constant SchwierigkeitsgradArray := (
                                                                                 SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum => 4,
                                                                                 SpielDatentypen.Schwierigkeitsgrad_Mittel_Enum => 2,
                                                                                 SpielDatentypen.Schwierigkeitsgrad_Schwer_Enum => 1
                                                                                );

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
