with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

package EinheitHeilenLogik is
   pragma Elaborate_Body;

   function EinheitHeilen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitHeilenLogik;
