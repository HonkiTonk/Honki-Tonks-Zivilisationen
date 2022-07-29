pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

private with Sf.Graphics;
private with Sf.Graphics.Rect;

package GrafikAllgemeinSFML is

   procedure FensterAnpassen;
   procedure BildrateÄndern;
   procedure SchriftartFestlegen;
   procedure MauszeigerFestlegen;

   procedure MauszeigerPositionFestlegen
     (PositionExtern : in Sf.System.Vector2.sfVector2i);

private

   NeueAuflösung : Sf.Graphics.Rect.sfFloatRect;

end GrafikAllgemeinSFML;
