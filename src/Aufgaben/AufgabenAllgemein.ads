pragma SPARK_Mode (On);

with Sf.Graphics;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenDatentypen;

package AufgabenAllgemein is

   procedure Beschreibung
     (KartenVerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr);

   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);

private

   AktuelleVerbesserung : Positive;

end AufgabenAllgemein;
