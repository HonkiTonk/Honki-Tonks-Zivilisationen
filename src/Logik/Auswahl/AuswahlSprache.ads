pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

package AuswahlSprache is
      
   type AktuelleSprachenArray is array (1 .. 11) of Unbounded_Wide_Wide_String;
   AktuelleSprachen : AktuelleSprachenArray;
   
   

   function AuswahlSprache
     return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => AuswahlSprache'Result)'Length > 0
               );
   
private

   SchriftartFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   MehrereSeiten : Boolean;

   Ende : Positive;
      
   ZehnerReihe : Natural;
   AktuelleAuswahl : Natural;
   
   StartPositionYAchse : constant Float := 10.00;
   Zeile : Float;
   TextPositionMaus : Float;
         
   Mausposition : Sf.System.Vector2.sfVector2f;
   
   procedure SprachenListeFestlegen;
   
   
   
   function MausAuswahl
     return Natural;
   
   function AuswahlSpracheSFML
     return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => AuswahlSpracheSFML'Result)'Length > 0
               );

end AuswahlSprache;
