with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

with LeseGrenzen;

package KIEinheitGefahrenverhaltenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type RassenDatentypen.Rassen_Enum;

   procedure GefahrenHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindlicheEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
               and
                 FeindlicheEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => FeindlicheEinheitExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (FeindlicheEinheitExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Rasse /= FeindlicheEinheitExtern.Rasse
              );

end KIEinheitGefahrenverhaltenLogik;
