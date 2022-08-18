pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.Graphics;
private with Sf.Graphics.Color;
private with Sf.Graphics.ConvexShape;
private with Sf.System.Vector2;

private with AuswahlSprache;

package AnzeigeSprachauswahlSFML is
   
   procedure AnzeigeSprache;
    
private
   
   Erstaufruf : Boolean := True;
   MehrereSeiten : Boolean;

   AktuelleAuswahl : Natural;
   Ende : Natural;
            
   AktuelleTextFarbe : Sf.Graphics.Color.sfColor;
   
   AktuelleTextbreite : Float;
   NeueTextbreite : Float;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   Textposition : Sf.System.Vector2.sfVector2f;
      
   PfeilAccess : constant Sf.Graphics.sfConvexShape_Ptr := Sf.Graphics.ConvexShape.create;
   
   AktuelleSprachen : AuswahlSprache.AktuelleSprachenArray;

end AnzeigeSprachauswahlSFML;
