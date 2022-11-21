with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KampfRecords;
private with EinheitenDatentypen;

with LeseGrenzen;

package KampfsystemEinheitenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;

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
                 VerteidigerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => VerteidigerExtern.Rasse)
               and
                 AngreiferExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => AngreiferExtern.Rasse)
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
                 VerteidigerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => VerteidigerExtern.Rasse)
               and
                 AngreiferExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => AngreiferExtern.Rasse)
              );

end KampfsystemEinheitenLogik;
