with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

package RundenendeLogik is
   pragma Elaborate_Body;

   function BerechnungenRundenende
     return Boolean;

private

   procedure RundenanzahlSetzen;
   procedure GeldForschungDiplomatieÄndern;

   procedure GeldForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );



   function NachSiegWeiterspielen
     return Boolean;

   function MenschlicherSpielerVorhanden
     return Boolean;

end RundenendeLogik;
