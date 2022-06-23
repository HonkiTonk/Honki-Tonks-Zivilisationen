pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SonstigeVariablen;
with KartengrundDatentypen;
with SpielVariablen;
with AufgabenDatentypen;
with EinheitenDatentypen;
with KartenVerbesserungDatentypen;

package FestungErmitteln is

   function FestungErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   VorhandeneVerbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;

   Arbeitszeit : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   Grundzeit : EinheitenDatentypen.MaximaleEinheitenMitNullWert := 1;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   function OberflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return EinheitenRecords.ArbeitRecord;

   function UnterflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Enum)
      return EinheitenRecords.ArbeitRecord;

   function UnterflächeWasser
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return EinheitenRecords.ArbeitRecord;

   ----------------------- Später Festungen für den Kern einbauen.

end FestungErmitteln;
