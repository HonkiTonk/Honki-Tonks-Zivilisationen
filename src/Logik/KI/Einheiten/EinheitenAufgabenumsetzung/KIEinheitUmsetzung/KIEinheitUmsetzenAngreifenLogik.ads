with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

with LeseGrenzen;

package KIEinheitUmsetzenAngreifenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitUmsetzenAngreifenLogik;
