pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with GlobaleVariablen;
with SystemRecords;
with TastenbelegungDatentypen;
with SpielVariablen;
with SonstigeVariablen;

package InDerStadt is

   AktuelleStadtNummerGrafik : EinheitStadtDatentypen.MaximaleStädteMitNullWert;

   procedure InDerStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);

private

   Befehl : TastenbelegungDatentypen.Tastenbelegung_Enum;

   NeuerName : SystemRecords.TextEingabeRecord;

   function WasIstAusgewählt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Boolean;

end InDerStadt;
