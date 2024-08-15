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
      EinheitenkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenkoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 EinheitenkoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
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
   XAchsenbereich : Float;
         
   Scrollzeit : Time := Clock;
   
   YAchseÜbergänge : KartenRecords.KartenformYAchseRecord;
   XAchseÜbergänge : KartenRecords.KartenformXAchseRecord;
   Sichtbereich : KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   Viewfläche : Sf.System.Vector2.sfVector2f;
   Viewzentrum : Sf.System.Vector2.sfVector2f;
   Achsenviewfläche : Sf.System.Vector2.sfVector2f;
   
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   AlteCursorkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Koordinatenänderung : KartenRecords.AchsenKartenfeldRecord;
   
   procedure Platzierung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitenkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenkoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 EinheitenkoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
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
      EinheitenkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenkoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 EinheitenkoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
         
   function AlteYAchseFestlegen
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      YAchseAltExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteUmgebungEins
     with
       Pre => (
                 YAchseAltExtern <= LeseWeltkarteneinstellungen.YAchse
              );
   
   function AlteXAchseFestlegen
     (MausachseExtern : in Float;
      XAchseAltExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteUmgebungEins
     with
       Pre => (
                 XAchseAltExtern <= LeseWeltkarteneinstellungen.XAchse
              );

end CursorplatzierungAltGrafik;
