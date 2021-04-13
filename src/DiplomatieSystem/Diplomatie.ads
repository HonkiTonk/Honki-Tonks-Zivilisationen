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
            GlobaleVariablen.RassenImSpiel (AngreifendeRasseExtern) /= 0
          and
            GlobaleVariablen.RassenImSpiel (VerteidigendeRasseExtern) /= 0);

   function DiplomatischenStatusPrüfen
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleVariablen.StatusUntereinander
     with
       Pre =>
         (AngreifendeRasseExtern /= VerteidigendeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (AngreifendeRasseExtern) /= 0
          and
            GlobaleVariablen.RassenImSpiel (VerteidigendeRasseExtern) /= 0);

   procedure GegnerAngreifenOderNicht
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GegnerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Rasse /= GegnerExtern.Rasse
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
          and
            GegnerExtern.Rasse in GlobaleDatentypen.Rassen
          and
            GegnerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0)
          and
            (if GegnerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (GegnerExtern.Rasse) /= 0));

private

   Gewonnen : Boolean;

   BereitsImKrieg : GlobaleVariablen.StatusUntereinander;

   Wahl : Integer;

end Diplomatie;
