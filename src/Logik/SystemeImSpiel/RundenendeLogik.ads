private with RassenDatentypen;

private with LeseRassenbelegung;

package RundenendeLogik is
   pragma Elaborate_Body;

   function BerechnungenRundenende
     return Boolean;

private
   use type RassenDatentypen.Spieler_Enum;

   Weiterspielen : Boolean;

   procedure GeldForschungDiplomatieÄndern;

   procedure GeldForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );



   function NachSiegWeiterspielen
     return Boolean;

   function MenschlicherSpielerVorhanden
     return Boolean;

end RundenendeLogik;
