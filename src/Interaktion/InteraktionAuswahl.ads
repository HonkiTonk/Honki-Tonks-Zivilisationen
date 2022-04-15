pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;

with SystemDatentypen;
with GlobaleTexte;

package InteraktionAuswahl is

   -- Immer das Längste verwenden.
   -- Wobei ein längeres Array hier auch keine Pobleme machen sollte?
   -- Mit den aktuellen Prüfungen sollte doch sowieso immer nur der korrekte Bereich funktionieren, oder?
   type PositionenEinfachArray is array (SystemDatentypen.Menü_Einfach_Enum'Range, GlobaleTexte.Rassenauswahl'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinfach : PositionenEinfachArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

   type PositionenZusatztextArray is array (SystemDatentypen.Menü_Zusatztext_Enum'Range, 1 .. Integer (0.50 * Float (GlobaleTexte.Rassenauswahl'Last))) of Sf.Graphics.Rect.sfFloatRect;
   PositionenZusatztext : PositionenZusatztextArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

   -- Die zweite Dimension ist noch nicht korrekt festgelegt.
   type PositionenKomplexArray is array (SystemDatentypen.Menü_Komplex_Enum'Range, GlobaleTexte.Kartenform'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenKomplex : PositionenKomplexArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

end InteraktionAuswahl;
