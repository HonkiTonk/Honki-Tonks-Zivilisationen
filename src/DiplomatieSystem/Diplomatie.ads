pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Diplomatie is

   procedure DiplomatieAuswählen;
   procedure KriegDurchDirektenAngriff (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) with
     Pre => (AngreifendeRasse /= VerteidigendeRasse and GlobaleVariablen.RassenImSpiel (AngreifendeRasse) /= 0 and GlobaleVariablen.RassenImSpiel (VerteidigendeRasse) /= 0);

   function DiplomatischenStatusPrüfen (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) return GlobaleVariablen.StatusUntereinander with
     Pre => (AngreifendeRasse /= VerteidigendeRasse and GlobaleVariablen.RassenImSpiel (AngreifendeRasse) /= 0 and GlobaleVariablen.RassenImSpiel (VerteidigendeRasse) /= 0);

   function GegnerAngreifenOderNicht (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Gegner : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => (EinheitRasseNummer.Rasse /= Gegner.Rasse and EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and Gegner.Rasse in GlobaleDatentypen.Rassen and Gegner.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0)
             and (if Gegner.Rasse > 0 then GlobaleVariablen.RassenImSpiel (Gegner.Rasse) /= 0));

private

   Angreifen : Boolean;
   Gewonnen : Boolean;

   BereitsImKrieg : GlobaleVariablen.StatusUntereinander;

   Wahl : Integer;

end Diplomatie;
