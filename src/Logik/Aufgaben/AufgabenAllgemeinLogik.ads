with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

with LeseGrenzen;
with LeseRassenbelegung;

package AufgabenAllgemeinLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end AufgabenAllgemeinLogik;
