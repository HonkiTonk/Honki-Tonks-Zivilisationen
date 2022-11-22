with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package KIEinheitLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Einheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

private

   FeindlicheEinheit : EinheitenRecords.RasseEinheitnummerRecord;

end KIEinheitLogik;
