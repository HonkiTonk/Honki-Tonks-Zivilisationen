private with Sf;
private with Sf.System.Vector2;

with SpeziesDatentypen;
with EinheitenRecords;

private with KartenRecords;
private with KartenDatentypen;

with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package WeltkarteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure WeltkarteAnzeigen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   
   Transparents : Sf.sfUint8;
   
   Sichtbereich : KartenDatentypen.KartenfeldPositiv;
      
   Feldposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   CursorKoordinatenAlt : KartenRecords.AchsenKartenfeldNaturalRecord;
   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
         
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

end WeltkarteGrafik;
