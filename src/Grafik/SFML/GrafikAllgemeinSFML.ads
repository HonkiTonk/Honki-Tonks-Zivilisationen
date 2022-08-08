pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.Graphics;
private with Sf.Graphics.Rect;

package GrafikAllgemeinSFML is

   procedure FensterAnpassen;
   procedure BildrateÄndern;
   procedure MauszeigerFestlegen;

private

   NeueAuflösung : Sf.Graphics.Rect.sfFloatRect;

end GrafikAllgemeinSFML;
