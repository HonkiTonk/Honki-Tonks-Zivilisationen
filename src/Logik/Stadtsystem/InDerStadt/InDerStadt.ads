pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with GlobaleVariablen;
with SystemRecords;
with SystemKonstanten;
with TastenbelegungDatentypen;

package InDerStadt is

   AktuelleStadtNummerGrafik : EinheitStadtDatentypen.MaximaleStädteMitNullWert;

   procedure InDerStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante);

private

   Befehl : TastenbelegungDatentypen.Tastenbelegung_Enum;

   NeuerName : SystemRecords.TextEingabeRecord;

   function WasIstAusgewählt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end InDerStadt;
