pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with SystemRecords;

package InDerStadt is

   AktuelleRasseStadt : EinheitStadtRecords.RassePlatznummerRecord;

   procedure InDerStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch);

private

   Befehl : SystemDatentypen.Tastenbelegung_Enum;

   NeuerName : SystemRecords.TextEingabeRecord;

   function WasIstAusgewählt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end InDerStadt;
