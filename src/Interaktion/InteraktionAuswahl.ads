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
   type PositionenMenüeinträgeArray is array (MenueDatentypen.Welches_Menü_Vorhanden_Enum'Range, 1 .. SystemKonstanten.LängstesMenü) of Sf.Graphics.Rect.sfFloatRect;
   PositionenMenüeinträge : PositionenMenüeinträgeArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

end InteraktionAuswahl;
