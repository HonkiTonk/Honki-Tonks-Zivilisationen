with StadtRecords;
with StadtKonstanten;
with RassenDatentypen;

private with ProduktionDatentypen;
private with KartenDatentypen;
private with KartenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package FelderbewirtschaftungLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BelegenEntfernenExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean;
      FeldExtern : in FeldRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function OptimalesFeldErmitteln
     (ZuwachsSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return FeldRecord
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end FelderbewirtschaftungLogik;
