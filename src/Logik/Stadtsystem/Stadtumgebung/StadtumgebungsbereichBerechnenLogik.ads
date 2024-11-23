with SpeziesDatentypen;
with StadtKonstanten;
with StadtRecords;

private with StadtDatentypen;
private with KartenRecords;

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
      
   GroßeStadt : constant KartenRecords.UmgebungDreiRecord := (3, 3);
   MittlereStadt : constant KartenRecords.UmgebungDreiRecord := (2, 2);
   KleineStadt : constant KartenRecords.UmgebungDreiRecord := (1, 1);
   
   Umgebung : KartenRecords.UmgebungDreiRecord;
   
   Einwohner : StadtDatentypen.Einwohner;
   
   procedure StadtumgebungErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end StadtumgebungsbereichBerechnenLogik;
