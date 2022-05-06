pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with ForschungenDatentypen;
with SonstigeVariablen;

package ForschungAnzeigeKonsole is

   procedure ForschungAnzeige;

   procedure ForschungsBaum
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

private

   ErsterDurchlauf : Boolean;

   AktuelleAuswahl : ForschungenDatentypen.ForschungIDNichtMöglich;

   procedure Ermöglicht
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in ForschungenDatentypen.ForschungID)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure Benötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in ForschungenDatentypen.ForschungID)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

end ForschungAnzeigeKonsole;
