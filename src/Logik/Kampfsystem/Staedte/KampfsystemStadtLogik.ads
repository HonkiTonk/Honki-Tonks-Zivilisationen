with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with StadtRecords;

private with KampfRecords;
private with EinheitenDatentypen;

package KampfsystemStadtLogik is
   pragma Elaborate_Body;

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
                 AngreifendeEinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (AngreifendeEinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 VerteidigendeStadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigendeStadtRasseNummerExtern.Rasse).Städtegrenze
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
                 AngreifendeEinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (AngreifendeEinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 VerteidigendeStadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigendeStadtRasseNummerExtern.Rasse).Städtegrenze
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
                 AngreifendeEinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (AngreifendeEinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 VerteidigendeStadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigendeStadtRasseNummerExtern.Rasse).Städtegrenze
              );

end KampfsystemStadtLogik;
