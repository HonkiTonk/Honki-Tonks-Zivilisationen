pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtDatentypen;
with GlobaleVariablen;

package ForschungAnzeigeKonsole is

   procedure ForschungAnzeige;

   procedure ForschungsBaum
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

private

   ErsterDurchlauf : Boolean;

   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;

   procedure Ermöglicht
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure Benötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

end ForschungAnzeigeKonsole;
