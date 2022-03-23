pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenVerbesserungDatentypen;

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
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemDatentypen.Leer_Spieler_Enum);

private

   AktuelleVerbesserung : Positive;

   BeschreibungText : Unbounded_Wide_Wide_String;

end AufgabenAllgemein;
