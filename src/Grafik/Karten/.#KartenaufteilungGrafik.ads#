private with Sf.System.Vector2;

with SpeziesDatentypen;
with EinheitenDatentypen;
with EinheitenRecords;
with StadtRecords;
with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KartenaufteilungGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   procedure Weltkarte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure Stadtkarte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   RechtsLinksBefehlsanzeige : Boolean;
   
   Position : Sf.System.Vector2.sfVector2f;
   Viewgröße : Sf.System.Vector2.sfVector2f;

end KartenaufteilungGrafik;
