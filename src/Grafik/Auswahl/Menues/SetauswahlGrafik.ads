private with Ada.Strings.Unbounded;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;
private with Sf.Graphics.ConvexShape;
private with Sf.Graphics;

private with ArraysHTSEB;

private with GrafikRecordKonstanten;

package SetauswahlGrafik is

   procedure Setauswahl
     (SpracheExtern : in Boolean);
   
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
   
   SchriftartAccess : Sf.Graphics.sfFont_Ptr := null;
   
   PfeilAccess : constant Sf.Graphics.sfConvexShape_Ptr := Sf.Graphics.ConvexShape.create;
   
   Auswahlmöglichkeiten : ArraysHTSEB.SetsArray;
   
   procedure Sprachenauswahl
     (SpracheExtern : in Boolean;
      ZeileExtern : in Positive)
     with
       Pre => (
                 ZeileExtern in Auswahlmöglichkeiten'Range
              );

end SetauswahlGrafik;
