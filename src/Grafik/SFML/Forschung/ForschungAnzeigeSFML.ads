pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.RectangleShape;
with Sf.System.Vector2;

with EinheitStadtDatentypen;
with ForschungAllgemein;

package ForschungAnzeigeSFML is

   procedure ForschungAnzeige;
   
private
   
   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;
   Ende : EinheitStadtDatentypen.MinimimMaximumID;
   
   WelcherText : Positive;
   
   Zeilenabstand : Float;
   AbstandÜberschrift : Float;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   
   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   TextPosition : Sf.System.Vector2.sfVector2f;
   
   ForschungText : ForschungAllgemein.ForschungTextArray;
   
   procedure WeiterenTextAnzeigen
     (WelcherTextExtern : in Natural);

end ForschungAnzeigeSFML;
