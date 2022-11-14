with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

package KIEinheitUmsetzenVerteidigungskriegLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function VerteidigungskriegVorbereiten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitUmsetzenVerteidigungskriegLogik;
