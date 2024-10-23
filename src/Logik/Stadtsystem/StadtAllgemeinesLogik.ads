with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with SystemRecords;
private with StadtDatentypen;
private with KartenverbesserungDatentypen;
private with KartenRecords;

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
   
   procedure StädteSortieren
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   StadtVorhanden : KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum;
   
   Stadtumgebung : KartenRecords.UmgebungDreiRecord;
   
   AlterPlatz : StadtDatentypen.StädtebereichVorhanden;
   
   Stadtgrenze : StadtDatentypen.Städtebereich;
   
   NeuerName : SystemRecords.TextEingabeRecord;
   
   Kartenwert : KartenRecords.KartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.KartenfeldNaturalRecord;
      
end StadtAllgemeinesLogik;
