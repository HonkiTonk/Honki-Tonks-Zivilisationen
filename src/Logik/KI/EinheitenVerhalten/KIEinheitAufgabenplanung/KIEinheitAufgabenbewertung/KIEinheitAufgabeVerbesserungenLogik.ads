pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with ForschungenDatentypen;

with KIDatentypen;

package KIEinheitAufgabeVerbesserungenLogik is

   function StadtumgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

private

   NurWege : constant KIDatentypen.AufgabenWichtigkeitKlein := 25;
   AuchVerbesserungen : constant KIDatentypen.AufgabenWichtigkeitKlein := 50;
   Gesamtwert : KIDatentypen.AufgabenWichtigkeitKlein;
   Zwischenwert : KIDatentypen.AufgabenWichtigkeitKlein;

   NötigeTechnologie : ForschungenDatentypen.ForschungIDNichtMöglich;



   function MöglicheVerbesserungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitAufgabeVerbesserungenLogik;
