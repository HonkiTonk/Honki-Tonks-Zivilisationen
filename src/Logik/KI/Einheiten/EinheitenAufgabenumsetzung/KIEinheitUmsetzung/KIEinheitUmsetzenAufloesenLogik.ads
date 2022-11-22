with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package KIEinheitUmsetzenAufloesenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitUmsetzenAufloesenLogik;
