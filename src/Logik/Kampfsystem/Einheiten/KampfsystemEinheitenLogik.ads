with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KampfRecords;
private with EinheitenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KampfsystemEinheitenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spezies_Enum;
   use type SpeziesDatentypen.Spieler_Enum;

   function KampfsystemNahkampf
     (AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      VerteidigerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 AngreiferExtern.Spezies /= VerteidigerExtern.Spezies
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => AngreiferExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => VerteidigerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 VerteidigerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => VerteidigerExtern.Spezies)
               and
                 AngreiferExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => AngreiferExtern.Spezies)
              );

private

   KampfwerteVerteidiger : KampfRecords.KampfwerteRecord;
   KampfwerteAngreifer : KampfRecords.KampfwerteRecord;

   IDAngreifer : EinheitenDatentypen.EinheitenID;
   IDVerteidiger : EinheitenDatentypen.EinheitenID;

   Kampfergebnis : Integer;



   function Kampf
     (VerteidigerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord;
      AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
     with
       Pre => (
                 AngreiferExtern.Spezies /= VerteidigerExtern.Spezies
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => AngreiferExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => VerteidigerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 VerteidigerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => VerteidigerExtern.Spezies)
               and
                 AngreiferExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => AngreiferExtern.Spezies)
              );

end KampfsystemEinheitenLogik;
