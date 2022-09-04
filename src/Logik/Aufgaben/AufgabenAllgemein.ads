pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenverbesserungDatentypen;

package AufgabenAllgemein is

   function BeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum)
      return Wide_Wide_String;

   function BeschreibungWeg
     (KartenWegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum)
      return Wide_Wide_String;

   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   AktuelleVerbesserung : Positive;
   AktuellerWeg : Positive;

   BeschreibungText : Unbounded_Wide_Wide_String;

end AufgabenAllgemein;
