with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with SystemRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package StadtAllgemeinesLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure NeuerStadtname
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   NeuerName : SystemRecords.TextEingabeRecord;

end StadtAllgemeinesLogik;
