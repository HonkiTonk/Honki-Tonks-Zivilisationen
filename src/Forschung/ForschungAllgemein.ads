pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package ForschungAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.ForschungIDMitNullWert);

   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   procedure ForschungsBaum
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   procedure ForschungFortschritt;



   function ForschungAnforderungErfüllt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in GlobaleDatentypen.ForschungID)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

private

   ErsterDurchlauf : Boolean;

   WasErforschtWerdenSoll : GlobaleDatentypen.ForschungIDMitNullWert;

   AktuelleAuswahl : GlobaleDatentypen.KartenverbesserungEinheitenID;
   Ende : GlobaleDatentypen.ForschungID;

   procedure Ermöglicht
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in GlobaleDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   procedure Benötigt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungNummerExtern : in GlobaleDatentypen.ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   function AuswahlForschungNeu
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

end ForschungAllgemein;
