pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;

with SystemDatentypen;
with GlobaleTexte;

package InteraktionAuswahl is

   -- Immer das Längste verwenden.
   -- Wobei ein längeres Array hier auch keine Pobleme machen sollte?
   -- Mit den aktuellen Prüfungen sollte doch sowieso immer nur der korrekte Bereich funktionieren, oder?
   type PositionenArray is array (SystemDatentypen.Menü_Ohne_Mit_Überschrift'Range, GlobaleTexte.Hauptmenü'Range) of Sf.Graphics.Rect.sfFloatRect;
   Positionen : PositionenArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

end InteraktionAuswahl;
