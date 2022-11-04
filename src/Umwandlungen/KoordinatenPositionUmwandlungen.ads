pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with KartenRecords;
with Weltkarte;

package KoordinatenPositionUmwandlungen is
   pragma Elaborate_Body;

   function KoordinatenZuKartenposition
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
         
       Post => (
                  KoordinatenZuKartenposition'Result.x >= -1.00
                and
                  KoordinatenZuKartenposition'Result.y >= -1.00
               );
   
   function KartenpositionZuKoordinaten
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              ),
         
       Post => (
                  KartenpositionZuKoordinaten'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  KartenpositionZuKoordinaten'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
private
   
   Sichtbereich : KartenDatentypen.KartenfeldPositiv;
   
   Feldposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   CursorKoordinatenAlt : KartenRecords.AchsenKartenfeldNaturalRecord;

end KoordinatenPositionUmwandlungen;
