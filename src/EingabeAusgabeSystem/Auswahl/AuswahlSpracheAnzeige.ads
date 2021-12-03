pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.Graphics.Color;
with Sf.Graphics.Text;
with Sf.Graphics.ConvexShape;

with AuswahlSprache;

package AuswahlSpracheAnzeige is
   
   procedure AnzeigeSpracheSFML;

   procedure AnzeigeSpracheKonsole;
    -- (AktuelleAuswahlExtern : in Positive;
    --  LetzteZeileExtern : in Positive);
    
private
   
   MehrereSeiten : Boolean;

   AktuelleAuswahl : Positive;
   Ende : Positive;
   LängsterText : Positive;
   
   StartPositionYAchse : constant Float := 10.00;
   ZeilenAbstand : Float;
   YPosition : Float;
   
   AktuelleTextFarbe : Sf.Graphics.Color.sfColor;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   PfeilAccess : constant Sf.Graphics.sfConvexShape_Ptr := Sf.Graphics.ConvexShape.create;
   
   AktuelleSprachen : AuswahlSprache.AktuelleSprachenArray;

end AuswahlSpracheAnzeige;
