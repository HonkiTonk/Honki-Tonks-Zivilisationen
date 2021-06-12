pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Diplomatie is

   procedure DiplomatieAuswählen
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

   procedure Erstkontakt
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) > 0
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) > 0);

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
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.StatusUntereinander
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) > 0
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) > 0);

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

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = 1
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = 1);

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = 1
             or
               GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = 1));

end Diplomatie;
