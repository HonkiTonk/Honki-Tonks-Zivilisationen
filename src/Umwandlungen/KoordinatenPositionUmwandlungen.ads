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

   function KoordinatenZuKartenposition
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
               --  LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               -- and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),
         
       Post => (
                  KoordinatenZuKartenposition'Result.x >= -1.00
                and
                  KoordinatenZuKartenposition'Result.y >= -1.00
               );
   
   function KartenpositionZuKoordinaten
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              ),
         
       Post => (
                  KartenpositionZuKoordinaten'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  KartenpositionZuKoordinaten'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );
   
private
   
   Sichtbereich : KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   Feldposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   CursorKoordinatenAlt : KartenRecords.AchsenKartenfeldNaturalRecord;

end KoordinatenPositionUmwandlungen;
