pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics.Rect;

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

with Karten;

package Vergleiche is
   
   function KoordinateLeervergleich
     (KoordinateExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinateExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinateExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function Koordinatenvergleich
     (KoordinateEinsExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      KoordinatenZweiExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinateEinsExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinateEinsExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 KoordinatenZweiExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenZweiExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function Auswahlposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      TextboxExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Boolean
     with
       Pre => (
                 TextboxExtern.left >= 0.00
               and
                 TextboxExtern.top >= 0.00
               and
                 TextboxExtern.width >= 0.00
               and
                 TextboxExtern.height >= 0.00
              );

end Vergleiche;
