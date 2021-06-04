pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Diplomatie is

   procedure DiplomatieAuswählen;

   procedure KriegDurchDirektenAngriff
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (AngreifendeRasseExtern /= VerteidigendeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (AngreifendeRasseExtern) > 0
          and
            GlobaleVariablen.RassenImSpiel (VerteidigendeRasseExtern) > 0);

   function DiplomatischenStatusPrüfen
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.StatusUntereinander
     with
       Pre =>
         (AngreifendeRasseExtern /= VerteidigendeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (AngreifendeRasseExtern) > 0
          and
            GlobaleVariablen.RassenImSpiel (VerteidigendeRasseExtern) > 0);

   procedure GegnerAngreifenOderNicht
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GegnerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Rasse /= GegnerExtern.Rasse
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GegnerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            GlobaleVariablen.RassenImSpiel (GegnerExtern.Rasse) > 0);

private

   Gewonnen : Boolean;

   Wahl : Integer;

end Diplomatie;
