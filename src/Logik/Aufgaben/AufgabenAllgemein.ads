pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenDatentypen;

package AufgabenAllgemein is

   function Beschreibung
     (KartenVerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
      return Wide_Wide_String;

   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);

private

   AktuelleVerbesserung : Positive;

   BeschreibungText : Unbounded_Wide_Wide_String;

end AufgabenAllgemein;
