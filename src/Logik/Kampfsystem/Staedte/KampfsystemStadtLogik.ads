with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with StadtRecords;

private with KampfRecords;
private with EinheitenDatentypen;

with LeseGrenzen;

package KampfsystemStadtLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;

   function KampfsystemStadt
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      VerteidigendeStadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (AngreifendeEinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (VerteidigendeStadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AngreifendeEinheitRasseNummerExtern.Rasse /= VerteidigendeStadtRasseNummerExtern.Rasse
               and
                 AngreifendeEinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => AngreifendeEinheitRasseNummerExtern.Rasse)
               and
                 VerteidigendeStadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => VerteidigendeStadtRasseNummerExtern.Rasse)
              );
   
private
         
   IDAngreifer : EinheitenDatentypen.EinheitenID;
   
   GesundheitStadt : Integer;
   Kampfergebnis : Integer;
   
   KampfwerteVerteidiger : KampfRecords.KampfwerteRecord;
   KampfwerteAngreifer : KampfRecords.KampfwerteRecord;
   
   
   
   function Kampfverlauf
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigendeStadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (AngreifendeEinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (VerteidigendeStadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AngreifendeEinheitRasseNummerExtern.Rasse /= VerteidigendeStadtRasseNummerExtern.Rasse
               and
                 AngreifendeEinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => AngreifendeEinheitRasseNummerExtern.Rasse)
               and
                 VerteidigendeStadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => VerteidigendeStadtRasseNummerExtern.Rasse)
              );
   
   function Kampf
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigendeStadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (AngreifendeEinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (VerteidigendeStadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AngreifendeEinheitRasseNummerExtern.Rasse /= VerteidigendeStadtRasseNummerExtern.Rasse
               and
                 AngreifendeEinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => AngreifendeEinheitRasseNummerExtern.Rasse)
               and
                 VerteidigendeStadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => VerteidigendeStadtRasseNummerExtern.Rasse)
              );

end KampfsystemStadtLogik;
