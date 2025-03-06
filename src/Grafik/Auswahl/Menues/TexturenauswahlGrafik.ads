private with Ada.Strings.Unbounded;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;
private with Sf.Graphics.ConvexShape;

private with TextArrays;
private with GrafikRecordKonstanten;

package TexturenauswahlGrafik is
   pragma Elaborate_Body;

   procedure Texturenauswahl;
   
private
   use Ada.Strings.Unbounded;
   
   MehrereSeitenVorhanden : Boolean;

   AktuelleAuswahl : Natural;
   Ende : Natural;
   
   AktuelleTextbreite : Float;
   NeueTextbreite : Float;
   
   AktuellerPfad : Unbounded_String := To_Unbounded_String (Source => "");
   NeuerPfad : Unbounded_String := To_Unbounded_String (Source => "");
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   AktuelleTextFarbe : Sf.Graphics.Color.sfColor;
   
   PfeilAccess : constant Sf.Graphics.sfConvexShape_Ptr := Sf.Graphics.ConvexShape.create;
   
   Auswahlmöglichkeiten : TextArrays.SprachenArray;

end TexturenauswahlGrafik;
