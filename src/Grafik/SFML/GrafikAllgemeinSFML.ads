pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

private with Sf.Graphics;
private with Sf.Graphics.Rect;
private with Sf.Graphics.View;

package GrafikAllgemeinSFML is

   procedure FensterAnpassen;
   procedure BildrateÄndern;
   procedure SchriftartFestlegen;
   procedure MauszeigerFestlegen;

   procedure MauszeigerPositionFestlegen
     (PositionExtern : in Sf.System.Vector2.sfVector2i);

private

   NeueAuflösung : Sf.Graphics.Rect.sfFloatRect;

   NeueAuflösungAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.createFromRect (rectangle => NeueAuflösung);

end GrafikAllgemeinSFML;
