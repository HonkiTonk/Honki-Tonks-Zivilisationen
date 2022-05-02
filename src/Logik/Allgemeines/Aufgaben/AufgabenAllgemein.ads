pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with KartenVerbesserungDatentypen;
with SonstigeVariablen;

package AufgabenAllgemein is

   function BeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum)
      return Wide_Wide_String;

   function BeschreibungWeg
     (KartenWegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum)
      return Wide_Wide_String;

   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

private

   AktuelleVerbesserung : Positive;
   AktuellerWeg : Positive;

   BeschreibungText : Unbounded_Wide_Wide_String;

end AufgabenAllgemein;
