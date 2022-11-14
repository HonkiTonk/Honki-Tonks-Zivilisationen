with Sf.System.Vector2;
with Sf.Graphics.Rect;

with KartenDatentypen;
with KartenRecords;
with Weltkarte;

package Vergleiche is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   
   function KoordinateLeervergleich
     (KoordinateExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinateExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinateExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function Koordinatenvergleich
     (KoordinateEinsExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      KoordinatenZweiExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinateEinsExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinateEinsExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 KoordinatenZweiExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenZweiExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function Auswahlposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      TextboxExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Boolean;
    -- with
    --   Pre => (
    --             TextboxExtern.left >= 0.00
    --           and
    --            TextboxExtern.top >= 0.00
     --          and
     --            TextboxExtern.width >= 0.00
     --          and
     --            TextboxExtern.height >= 0.00
     --         );

end Vergleiche;
