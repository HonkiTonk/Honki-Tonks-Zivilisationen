private with Sf.Graphics;
private with Sf.Graphics.Color;
private with Sf.Graphics.ConvexShape;
private with Sf.System.Vector2;

private with GrafikRecordKonstanten;
private with TextArrays;

package SprachauswahlGrafik is
   pragma Elaborate_Body;
   
   procedure Sprachauswahl;
    
private
   
   MehrereSeiten : Boolean;

   AktuelleAuswahl : Natural;
   Ende : Natural;
            
   AktuelleTextFarbe : Sf.Graphics.Color.sfColor;
   
   AktuelleTextbreite : Float;
   NeueTextbreite : Float;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   SchriftartAccess : Sf.Graphics.sfFont_Ptr := null;
      
   PfeilAccess : constant Sf.Graphics.sfConvexShape_Ptr := Sf.Graphics.ConvexShape.create;
   
   AktuelleSprachen : TextArrays.SprachenArray;

end SprachauswahlGrafik;
