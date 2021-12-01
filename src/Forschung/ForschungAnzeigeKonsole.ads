pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen;
with GlobaleVariablen;

package ForschungAnzeigeKonsole is

   procedure ForschungAnzeige;

   procedure ForschungsBaum
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

private

   ErsterDurchlauf : Boolean;

   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;

   procedure Ermöglicht
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

   procedure Benötigt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

end ForschungAnzeigeKonsole;
