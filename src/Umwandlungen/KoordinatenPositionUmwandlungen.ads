with Sf.System.Vector2;

with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package KoordinatenPositionUmwandlungen is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function KoordinatenKartenposition
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),
         
       Post => (
                  KoordinatenKartenposition'Result.x >= -1.00
                and
                  KoordinatenKartenposition'Result.y >= -1.00
               );
   
   function KartenpositionKoordinaten
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              ),
         
       Post => (
                  KartenpositionKoordinaten'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  KartenpositionKoordinaten'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );
   
private
   
   Sichtbereich : KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   Feldposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   CursorKoordinatenAlt : KartenRecords.AchsenKartenfeldNaturalRecord;

end KoordinatenPositionUmwandlungen;
