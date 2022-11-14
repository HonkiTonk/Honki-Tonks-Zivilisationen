with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with StadtDatentypen;

package KISiedleraufgabenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;

   procedure KISiedleraufgabenLogik
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

private

   VorhandeneStädte : StadtDatentypen.MaximaleStädteMitNullWert;

end KISiedleraufgabenLogik;
