pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SonstigeVariablen;
with KartengrundDatentypen;
with SpielVariablen;
with AufgabenDatentypen;
with EinheitStadtDatentypen;

package VerbesserungFestung is

   function VerbesserungFestung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

private

   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   Grundzeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert := 1;

   Arbeitswerte : EinheitStadtRecords.ArbeitRecord;

   function OberflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return EinheitStadtRecords.ArbeitRecord;

   function UnterflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Enum)
      return EinheitStadtRecords.ArbeitRecord;

   function UnterflächeWasser
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return EinheitStadtRecords.ArbeitRecord;

   ----------------------- Später Festungen für den Kern einbauen.

end VerbesserungFestung;
