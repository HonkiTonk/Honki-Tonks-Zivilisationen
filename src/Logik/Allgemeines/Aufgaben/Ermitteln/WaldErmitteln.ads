pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with KartengrundDatentypen;
with SonstigeVariablen;
with AufgabenDatentypen;
with EinheitStadtDatentypen;
with EinheitenRecords;

package WaldErmitteln is

   function WaldErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

private

   ------------------------- Diesen Bool mal in ein konstantes Array umschreiben, so dass man das überall verwenden kann und man zur Prüfung nur noch reinspringen muss.
   VorarbeitNötig : Boolean;

   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   Grundzeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert := 1;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitenRecords.ArbeitRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitenRecords.ArbeitRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

end WaldErmitteln;
