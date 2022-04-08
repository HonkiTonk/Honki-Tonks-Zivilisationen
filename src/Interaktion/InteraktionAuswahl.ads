pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;

with SystemDatentypen;
with GlobaleTexte;

package InteraktionAuswahl is

   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;

   -- Immer das Längste verwenden.
   -- Wobei ein längeres Array hier auch keine Pobleme machen sollte?
   type PositionenArray is array (SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range, GlobaleTexte.Hauptmenü'Range) of Sf.Graphics.Rect.sfFloatRect;
   Positionen : PositionenArray;

end InteraktionAuswahl;
