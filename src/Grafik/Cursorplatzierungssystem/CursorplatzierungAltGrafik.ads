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
   use type KartenDatentypen.Kartenfeld;

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
   
   KeineÄnderung : constant KartenDatentypen.UmgebungsbereichEins := 0;
   RichtungNull : constant KartenDatentypen.UmgebungsbereichEins := -1;
   RichtungMaximum : constant KartenDatentypen.UmgebungsbereichEins := 1;
   
   Scrollgeschwindigkeitsänderung : constant KartenDatentypen.KartenfeldPositiv := 4;
   AktuelleSichtweite : KartenDatentypen.KartenfeldPositiv;
   Sichthöhe : KartenDatentypen.KartenfeldPositiv;
   Sichtbreite : KartenDatentypen.KartenfeldPositiv;
      
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
      YAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
     with
       Pre => (
                 YAchseAltExtern <= LeseWeltkarteneinstellungen.YAchse
              );
   
   function AlteXAchseFestlegen
     (MausachseExtern : in Float;
      XAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
     with
       Pre => (
                 XAchseAltExtern <= LeseWeltkarteneinstellungen.XAchse
              );

end CursorplatzierungAltGrafik;
