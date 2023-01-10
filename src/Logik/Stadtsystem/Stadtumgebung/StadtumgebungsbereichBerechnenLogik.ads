with SpeziesDatentypen;
with StadtKonstanten;
with StadtRecords;
with ProduktionDatentypen;

private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package StadtumgebungsbereichBerechnenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure StadtumgebungsbereichFestlegen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   Einwohner : ProduktionDatentypen.Einwohner;
   
   procedure StadtumgebungErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end StadtumgebungsbereichBerechnenLogik;
