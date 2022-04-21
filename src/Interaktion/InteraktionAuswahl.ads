pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;

with MenueDatentypen;
-- with GlobaleTexte;
with SystemKonstanten;

package InteraktionAuswahl is

   LetzteTextpositionKartengröße : Float;

   -- Immer das Längste verwenden.
   -- Wobei ein längeres Array hier auch keine Pobleme machen sollte?
   -- Mit den aktuellen Prüfungen sollte doch sowieso immer nur der korrekte Bereich funktionieren, oder?
   type PositionenEinfachArray is array (MenueDatentypen.Menü_Einfach_Enum'Range, 1 .. SystemKonstanten.LängstesMenü) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinfach : PositionenEinfachArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

   -- Die zweite Dimension ist noch nicht korrekt festgelegt.
   ---------------------- Wird vielleicht gar nicht gebraucht?
   -- type PositionenKomplexArray is array (MenueDatentypen.Menü_Komplex_Enum'Range, GlobaleTexte.Kartenform'Range) of Sf.Graphics.Rect.sfFloatRect;
   -- PositionenKomplex : PositionenKomplexArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

end InteraktionAuswahl;
