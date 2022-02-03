pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen;
with GlobaleVariablen;
with SystemKonstanten;

package ForschungAnzeigeKonsole is

   procedure ForschungAnzeige;

   procedure ForschungsBaum
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

private

   ErsterDurchlauf : Boolean;

   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;

   procedure Ermöglicht
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   procedure Benötigt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in EinheitStadtDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

end ForschungAnzeigeKonsole;
