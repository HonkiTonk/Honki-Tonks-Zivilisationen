with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;
with StadtRecords;
with StadtKonstanten;

private with KampfRecords;
private with EinheitenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KampfsystemStadtLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spezies_Enum;
   use type SpeziesDatentypen.Spieler_Enum;

   function KampfwerteErmitteln
     (AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      VerteidigerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => AngreiferExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => VerteidigerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AngreiferExtern.Spezies /= VerteidigerExtern.Spezies
               and
                 AngreiferExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => AngreiferExtern.Spezies)
               and
                 VerteidigerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => VerteidigerExtern.Spezies)
              );
   
private
         
   IDAngreifer : EinheitenDatentypen.EinheitenID;
   
   GesundheitStadt : Integer;
   Kampfergebnis : Integer;
   
   KampfwerteVerteidiger : KampfRecords.KampfwerteRecord;
   KampfwerteAngreifer : KampfRecords.KampfwerteRecord;
   
   
      
   function Kampf
     (AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => AngreiferExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => VerteidigerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AngreiferExtern.Spezies /= VerteidigerExtern.Spezies
               and
                 AngreiferExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => AngreiferExtern.Spezies)
               and
                 VerteidigerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => VerteidigerExtern.Spezies)
              );
   
   function Kampfverlauf
     (AngreiferExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => AngreiferExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => VerteidigerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AngreiferExtern.Spezies /= VerteidigerExtern.Spezies
               and
                 AngreiferExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => AngreiferExtern.Spezies)
               and
                 VerteidigerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => VerteidigerExtern.Spezies)
              );

end KampfsystemStadtLogik;
