with StadtRecords;
with StadtKonstanten;
with SpeziesDatentypen;

private with ProduktionDatentypen;
private with KartenDatentypen;
private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package FelderbewirtschaftungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsSchwundExtern : in Boolean;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   NutzbarerBereich : KartenDatentypen.Kartenfeld;
   
   Bewertung : ProduktionDatentypen.Produktion;
      
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type FeldRecord is record
      
      Bewertung : ProduktionDatentypen.Produktion;
      YKoordinate : KartenDatentypen.UmgebungsbereichDrei;
      XKoordinate : KartenDatentypen.UmgebungsbereichDrei;
      
   end record;
   
   Feld : FeldRecord;
   
   procedure ArbeiterBelegenEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BelegenEntfernenExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean;
      FeldExtern : in FeldRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function OptimalesFeldErmitteln
     (ZuwachsSchwundExtern : in Boolean;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return FeldRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end FelderbewirtschaftungLogik;
