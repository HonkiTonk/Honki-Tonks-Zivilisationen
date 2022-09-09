pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KampfDatentypen;

private with KampfRecords;

package KampfsystemEinheiten is

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

   procedure KampfBerechnung
     (VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AngriffExtern : in KampfDatentypen.Kampfwerte;
      VerteidigungExtern : in KampfDatentypen.Kampfwerte)
     with
       Pre => (
                 VerteidigerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (VerteidigerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   WelcherFall : KampfDatentypen.Kampf_Unterschiede_Enum;

   AngerichteterSchaden : KampfDatentypen.Kampfwerte;

   Kampfglück : Float;

   KampfwerteVerteidiger : KampfRecords.KampfwerteRecord;
   KampfwerteAngreifer : KampfRecords.KampfwerteRecord;

   function Kampf
     (VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AngreiferExtern : in EinheitenRecords.RasseEinheitnummerRecord)
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

end KampfsystemEinheiten;
