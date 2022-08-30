pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics; use Sf.Graphics;

private with Sf.Window.Keyboard;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

with SystemRecords;

private with GrafikRecordKonstanten;

package AuswahlMenueSteuerungSFML is

   procedure AuswahlMenüSteuerung
     (AuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord);
   
private
   
   Zusatzabstand : Boolean;
      
   AktuelleBelegung : Sf.Window.Keyboard.sfKeyCode;
   
   Textarrayanpassung : constant Positive := 2;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   
   Farbe : Sf.Graphics.Color.sfColor;
   
   ViewflächeText : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   
   procedure FarbeFestlegen
     (AuswahlExtern : in Natural;
      TextnummerExtern : in Positive;
      TextaccessExtern : in Sf.Graphics.sfText_Ptr)
     with
       Pre => (
                 TextaccessExtern /= null
              );
   
   procedure BelegungAnzeigen
     (AuswahlExtern : in Natural);
   
   
   
   function BefehleAnzeigen
     (AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  BefehleAnzeigen'Result.x >= 0.00
                and
                  BefehleAnzeigen'Result.y >= 0.00
               );

end AuswahlMenueSteuerungSFML;
