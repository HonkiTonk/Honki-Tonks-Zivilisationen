pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.Graphics;
private with Sf.Graphics.Color;
private with Sf.Graphics.ConvexShape;

private with AuswahlSprache;

package AnzeigeSprachauswahlSFML is
   
   procedure AnzeigeSprache;
    
private
   
   MehrereSeiten : Boolean;

   AktuelleAuswahl : Positive;
   Ende : Positive;
   LängsterText : Positive;
   
   StartPositionYAchse : constant Float := 10.00;
   ZeilenAbstand : Float;
   YPosition : Float;
   
   AktuelleTextFarbe : Sf.Graphics.Color.sfColor;
      
   PfeilAccess : constant Sf.Graphics.sfConvexShape_Ptr := Sf.Graphics.ConvexShape.create;
   
   AktuelleSprachen : AuswahlSprache.AktuelleSprachenArray;

end AnzeigeSprachauswahlSFML;
