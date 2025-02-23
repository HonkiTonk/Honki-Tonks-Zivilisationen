private with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with Vergleiche;

package EinwohnersystemLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function EinwohnerZuweisenEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   YKoordinatenausgleich : constant KartenDatentypen.SenkrechtePositiv := 3;
   XKoordinatenausgleich : constant KartenDatentypen.WaagerechtePositiv := 3;
      
   Stadtfeld : KartenRecords.KartenfeldumgebungRecord;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   Feldfläche : Sf.System.Vector2.sfVector2f;
   
   Kartenwert : KartenRecords.KartenfeldNaturalRecord;
   
   procedure EinwohnerBelegungÄndern
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      SenkrechteExtern : in KartenDatentypen.Senkrechte;
      WaagerechteExtern : in KartenDatentypen.Waagerechte)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   procedure EinwohnerEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      SenkrechteExtern : in KartenDatentypen.Senkrechte;
      WaagerechteExtern : in KartenDatentypen.Waagerechte)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   procedure EinwohnerZuweisen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      SenkrechteExtern : in KartenDatentypen.Senkrechte;
      WaagerechteExtern : in KartenDatentypen.Waagerechte)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   
   
   function YMausfeldPrüfen is new Vergleiche.Achsenauswahlposition (GanzeZahl => KartenDatentypen.Senkrechte);
   function XMausfeldPrüfen is new Vergleiche.Achsenauswahlposition (GanzeZahl => KartenDatentypen.Waagerechte);

end EinwohnersystemLogik;
