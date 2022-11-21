with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

with LeseGrenzen;

package EinheitVerschanzenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function Verschanzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitVerschanzenLogik;
