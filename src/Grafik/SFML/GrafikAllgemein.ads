pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Rect;
with Sf.Graphics.View;

package GrafikAllgemein is

   procedure FensterAnpassen;

   procedure FensterAuflösungÄndern
     (NeueAuflösungExtern : in Sf.System.Vector2.sfVector2u);

   procedure BildrateÄndern
     (NeueBildrateExtern : in Sf.sfUint32);

   procedure SchriftartFestlegen;
   procedure MauszeigerFestlegen;

   procedure MauszeigerPositionFestlegen
     (PositionExtern : in Sf.System.Vector2.sfVector2i);

private

   NeueAuflösung : Sf.Graphics.Rect.sfFloatRect;
   NeueAuflösungAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.createFromRect (rectangle => NeueAuflösung);

end GrafikAllgemein;
