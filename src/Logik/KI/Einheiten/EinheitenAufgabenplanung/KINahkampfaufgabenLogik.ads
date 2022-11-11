with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

package KINahkampfaufgabenLogik is
   pragma Elaborate_Body;

   procedure Nahkämpferaufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KINahkampfaufgabenLogik;
