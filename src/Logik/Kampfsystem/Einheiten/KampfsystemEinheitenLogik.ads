pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KampfRecords;
private with EinheitenDatentypen;

package KampfsystemEinheitenLogik is

   function KampfsystemNahkampf
     (AngreiferExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 AngreiferExtern.Rasse /= VerteidigerExtern.Rasse
               and
                 SpielVariablen.Rassenbelegung (AngreiferExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (VerteidigerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 VerteidigerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
               and
                 AngreiferExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (AngreiferExtern.Rasse).Einheitengrenze
              );

private

   KampfwerteVerteidiger : KampfRecords.KampfwerteRecord;
   KampfwerteAngreifer : KampfRecords.KampfwerteRecord;

   IDAngreifer : EinheitenDatentypen.EinheitenID;
   IDVerteidiger : EinheitenDatentypen.EinheitenID;

   Kampfergebnis : Integer;



   function Kampf
     (VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord;
      AngreiferExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
     with
       Pre => (
                 AngreiferExtern.Rasse /= VerteidigerExtern.Rasse
               and
                 SpielVariablen.Rassenbelegung (AngreiferExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (VerteidigerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 VerteidigerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
               and
                 AngreiferExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (AngreiferExtern.Rasse).Einheitengrenze
              );

end KampfsystemEinheitenLogik;
