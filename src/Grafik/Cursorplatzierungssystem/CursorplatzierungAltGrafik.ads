with Ada.Calendar; use Ada.Calendar;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenDatentypen;
with KartenRecords;
with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package CursorplatzierungAltGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.Einheitenbereich;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   procedure CursorplatzierungAlt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitenkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenkoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 EinheitenkoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
   
   EinheitFolgen : Boolean;
   
   KeineYÄnderung : constant KartenDatentypen.SenkrechteUmgebungEins := 0;
   RichtungYNull : constant KartenDatentypen.SenkrechteUmgebungEins := -1;
   RichtungYMaximum : constant KartenDatentypen.SenkrechteUmgebungEins := 1;
   KeineXÄnderung : constant KartenDatentypen.WaagerechteUmgebungEins := 0;
   RichtungXNull : constant KartenDatentypen.WaagerechteUmgebungEins := -1;
   RichtungXMaximum : constant KartenDatentypen.WaagerechteUmgebungEins := 1;
   
   Scrollgeschwindigkeitsänderung : constant KartenDatentypen.SenkrechtePositiv := 4;
   AktuelleSichtweite : KartenDatentypen.SenkrechtePositiv;
   Sichthöhe : KartenDatentypen.SenkrechtePositiv;
   AktuelleSichtbreite : KartenDatentypen.WaagerechtePositiv;
      
   -- Dafür vielleicht zwei Werte einbauen, einen für niedrige und einen für hohe Auflösungen? äöü
   -- Oder einen Wert für große Kartenfelder und einen für Kleine? äöü
   Scrollbereichanteil : constant Float := 2.00;
   Waagerechtebereich : Float;
         
   Scrollzeit : Time := Clock;
   
   SenkrechteÜbergänge : KartenRecords.KartenformSenkrechteRecord;
   WaagerechteÜbergänge : KartenRecords.KartenformWaagerechteRecord;
   Sichtbereich : KartenRecords.KartenfeldumgebungPositivRecord;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   Viewfläche : Sf.System.Vector2.sfVector2f;
   Viewzentrum : Sf.System.Vector2.sfVector2f;
   Achsenviewfläche : Sf.System.Vector2.sfVector2f;
   
   Kartenwert : KartenRecords.KartenfeldNaturalRecord;
   AlteCursorkoordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   Koordinatenänderung : KartenRecords.KartenfeldRecord;
   
   procedure Platzierung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitenkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenkoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 EinheitenkoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   
   
   function BefehlsknöpfePrüfen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   function Einheitenbereich
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitenkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenkoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 EinheitenkoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
         
   function AlteSenkrechteFestlegen
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      SenkrechteAltExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteUmgebungEins
     with
       Pre => (
                 SenkrechteAltExtern <= LeseWeltkarteneinstellungen.Senkrechte
              );
   
   function AlteWaagerechteFestlegen
     (MausachseExtern : in Float;
      WaagerechteAltExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteUmgebungEins
     with
       Pre => (
                 WaagerechteAltExtern <= LeseWeltkarteneinstellungen.Waagerechte
              );

end CursorplatzierungAltGrafik;
