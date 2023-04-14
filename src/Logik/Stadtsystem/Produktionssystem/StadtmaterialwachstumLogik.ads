with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

with LeseSpeziesbelegung;
with LeseGrenzen;

package StadtmaterialwachstumLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure Material
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
private
   
   Bauprojekt : StadtRecords.BauprojektRecord;

end StadtmaterialwachstumLogik;
