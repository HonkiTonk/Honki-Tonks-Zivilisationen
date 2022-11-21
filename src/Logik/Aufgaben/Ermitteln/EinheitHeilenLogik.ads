with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

with LeseGrenzen;

package EinheitHeilenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function EinheitHeilen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitHeilenLogik;
