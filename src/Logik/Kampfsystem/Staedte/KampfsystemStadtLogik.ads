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

   function KampfsystemStadt
     (AngreifendeEinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      VerteidigendeStadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => AngreifendeEinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => VerteidigendeStadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AngreifendeEinheitSpeziesNummerExtern.Spezies /= VerteidigendeStadtSpeziesNummerExtern.Spezies
               and
                 AngreifendeEinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => AngreifendeEinheitSpeziesNummerExtern.Spezies)
               and
                 VerteidigendeStadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => VerteidigendeStadtSpeziesNummerExtern.Spezies)
              );
   
private
         
   IDAngreifer : EinheitenDatentypen.EinheitenID;
   
   GesundheitStadt : Integer;
   Kampfergebnis : Integer;
   
   KampfwerteVerteidiger : KampfRecords.KampfwerteRecord;
   KampfwerteAngreifer : KampfRecords.KampfwerteRecord;
   
   
   
   function Kampfverlauf
     (AngreifendeEinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigendeStadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => AngreifendeEinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => VerteidigendeStadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AngreifendeEinheitSpeziesNummerExtern.Spezies /= VerteidigendeStadtSpeziesNummerExtern.Spezies
               and
                 AngreifendeEinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => AngreifendeEinheitSpeziesNummerExtern.Spezies)
               and
                 VerteidigendeStadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => VerteidigendeStadtSpeziesNummerExtern.Spezies)
              );
   
   function Kampf
     (AngreifendeEinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwerteAngreiferExtern : in KampfRecords.KampfwerteRecord;
      VerteidigendeStadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KampfwerteVerteidigerExtern : in KampfRecords.KampfwerteRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => AngreifendeEinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => VerteidigendeStadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AngreifendeEinheitSpeziesNummerExtern.Spezies /= VerteidigendeStadtSpeziesNummerExtern.Spezies
               and
                 AngreifendeEinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => AngreifendeEinheitSpeziesNummerExtern.Spezies)
               and
                 VerteidigendeStadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => VerteidigendeStadtSpeziesNummerExtern.Spezies)
              );

end KampfsystemStadtLogik;
