pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

private with GrafikRecordKonstanten;

private with SpielstandlisteLogik;

package SpielstandmenueGrafik is

   procedure Spielstandmenü
     (AuswahlExtern : in Natural);
   
private
   
   SpeichernLaden : Boolean;
   MehrereSeiten : Boolean;
   
   Textbreite : Float;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;
      
   Spielstand : SpielstandlisteLogik.SpielstandArray;
   
   Erstellungszeit : Time;
   
   
   
   function Textanzeige
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),
      
       Post => (
                  Textanzeige'Result.x >= 0.00
                and
                  Textanzeige'Result.y >= 0.00
               );
   
   function TextSetzen
     (TextExtern : in Wide_Wide_String)
      return Wide_Wide_String;
   
end SpielstandmenueGrafik;
