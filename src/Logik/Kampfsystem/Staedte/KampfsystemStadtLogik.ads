pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KampfDatentypen; use KampfDatentypen;
with EinheitenRecords;
with SpielVariablen;
with StadtRecords;

private with KampfRecords;

package KampfsystemStadtLogik is

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
   
   WelcherFall : KampfDatentypen.Kampf_Unterschiede_Enum;
   
   GesundheitStadt : KampfDatentypen.Kampfwerte;
   AngerichteterSchaden : KampfDatentypen.Kampfwerte;
   
   Kampfglück : Float;
   
   KampfwerteVerteidiger : KampfRecords.KampfwerteRecord;
   KampfwerteAngreifer : KampfRecords.KampfwerteRecord;
   
   
   
   function SchadenStadtBerechnen
     (AngriffExtern : in KampfDatentypen.Kampfwerte;
      VerteidigungExtern : in KampfDatentypen.Kampfwerte;
      StadtgesundheitExtern : in KampfDatentypen.Kampfwerte)
      return KampfDatentypen.Kampfwerte
     with
       Pre => (
                 StadtgesundheitExtern > 0
              );
   
   function Kampfverlauf
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (AngreifendeEinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AngreifendeEinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (AngreifendeEinheitRasseNummerExtern.Rasse).Einheitengrenze
              );
   
   function Kampf
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

end KampfsystemStadtLogik;
