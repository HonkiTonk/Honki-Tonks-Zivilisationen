pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Diplomatie is

   procedure DiplomatieAuswählen;
   procedure KriegDurchDirektenAngriff (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) with
     Pre => AngreifendeRasse /= VerteidigendeRasse;

   function DiplomatischenStatusPrüfen (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) return Integer with
     Pre => AngreifendeRasse /= VerteidigendeRasse;

   function GegnerAngreifenOderNicht (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Gegner : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre => EinheitRasseNummer.Rasse /= Gegner.Rasse and EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
     and Gegner.Rasse in GlobaleDatentypen.Rassen and Gegner.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2);

private

   Angreifen : Boolean;
   Gewonnen : Boolean;

   BereitsImKrieg : Integer;
   Wahl : Integer;

end Diplomatie;
