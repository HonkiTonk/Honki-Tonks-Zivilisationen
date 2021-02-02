with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package Diplomatie is

   procedure DiplomatieAuswählen;
   procedure KriegDurchDirektenAngriff (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) with
     Pre => AngreifendeRasse /= VerteidigendeRasse;

   function DiplomatischenStatusPrüfen (AngreifendeRasse, VerteidigendeRasse : in GlobaleDatentypen.Rassen) return Integer with
     Pre => AngreifendeRasse /= VerteidigendeRasse;

   function GegnerAngreifenOderNicht (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; Gegner : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean with
     Pre => RasseExtern /= Gegner.Rasse;

private

   Angreifen : Boolean;
   Gewonnen : Boolean;

   BereitsImKrieg : Integer;
   Wahl : Integer;

end Diplomatie;
