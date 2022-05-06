pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.RectangleShape;
with Sf.System.Vector2;

with ForschungenDatentypen;

package ForschungAnzeigeSFML is

   procedure ForschungAnzeige;
   
private
   
   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   TextFestgelegt : Boolean := False;
   
   Überschrift : constant ForschungenDatentypen.ForschungIDMitNullWert := 0;
   
   AktuelleAuswahl : ForschungenDatentypen.ForschungIDMitNullWert;
   WelcherZusatztext : ForschungenDatentypen.ForschungIDMitNullWert;
   
   WelcherText : Positive;
   
   Zeilenabstand : Float;
   AbstandÜberschrift : Float;

   type TextAccessArray is array (ForschungenDatentypen.ForschungIDMitNullWert'Range) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (others => Sf.Graphics.Text.create);
   
   type ZusatztextAccessArray is array (ForschungenDatentypen.ForschungID'Range) of Sf.Graphics.sfText_Ptr;
   ZusatztextAccess : constant ZusatztextAccessArray := (others => Sf.Graphics.Text.create);
   
   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   
   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   TextPosition : Sf.System.Vector2.sfVector2f;
   
   
   
   function SchriftartFestlegen
     return Boolean;

   function SchriftgrößenFestlegen
     return Boolean;

   function SchriftfarbenFestlegen
     return Boolean;
   
   function TextFestlegen
     return Boolean;

end ForschungAnzeigeSFML;
