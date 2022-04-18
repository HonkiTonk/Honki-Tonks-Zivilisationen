pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;

with SystemDatentypen;
with GlobaleTexte;
with SystemKonstanten;

package InteraktionAuswahl is

   -- Immer das Längste verwenden.
   -- Wobei ein längeres Array hier auch keine Pobleme machen sollte?
   -- Mit den aktuellen Prüfungen sollte doch sowieso immer nur der korrekte Bereich funktionieren, oder?
   type PositionenEinfachArray is array (SystemDatentypen.Menü_Einfach_Enum'Range, 1 .. SystemKonstanten.LängstesMenü) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinfach : PositionenEinfachArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

   -- Die zweite Dimension ist noch nicht korrekt festgelegt.
   type PositionenKomplexArray is array (SystemDatentypen.Menü_Komplex_Enum'Range, GlobaleTexte.Kartenform'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenKomplex : PositionenKomplexArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

end InteraktionAuswahl;
