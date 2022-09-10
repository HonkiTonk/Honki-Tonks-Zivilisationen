pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.Graphics;
private with Sf.Graphics.Color;
private with Sf.Graphics.ConvexShape;
private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

private with SprachauswahlLogik;

package SprachauswahlGrafik is
   
   procedure Sprachauswahl;
    
private
   
   Erstaufruf : Boolean := True;
   MehrereSeiten : Boolean;

   AktuelleAuswahl : Natural;
   Ende : Natural;
            
   AktuelleTextFarbe : Sf.Graphics.Color.sfColor;
   
   AktuelleTextbreite : Float;
   NeueTextbreite : Float;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
      
   PfeilAccess : constant Sf.Graphics.sfConvexShape_Ptr := Sf.Graphics.ConvexShape.create;
   
   AktuelleSprachen : SprachauswahlLogik.AktuelleSprachenArray;

end SprachauswahlGrafik;
