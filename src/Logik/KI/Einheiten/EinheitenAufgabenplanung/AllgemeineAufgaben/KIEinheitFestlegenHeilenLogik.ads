with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

package KIEinheitFestlegenHeilenLogik is
   pragma Elaborate_Body;

   function Heilen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenHeilenLogik;
