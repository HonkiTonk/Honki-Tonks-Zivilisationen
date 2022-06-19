pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with StadtDatentypen;
with GlobaleVariablen;
with SystemRecords;
with TastenbelegungDatentypen;
with SpielVariablen;
with SonstigeVariablen;
with StadtRecords;

package InDerStadt is

   AktuelleStadtNummerGrafik : StadtDatentypen.MaximaleStädteMitNullWert;

   procedure InDerStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum);

private

   Befehl : TastenbelegungDatentypen.Tastenbelegung_Enum;

   NeuerName : SystemRecords.TextEingabeRecord;

   function WasIstAusgewählt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum);

end InDerStadt;
