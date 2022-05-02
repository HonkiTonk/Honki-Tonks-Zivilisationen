pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.System.Vector2;

with TastenbelegungDatentypen;

package AuswahlSprache is
   
   MehrereSeiten : Boolean;

   AktuelleAuswahl : Positive;
   Ende : Positive;
      
   type AktuelleSprachenArray is array (1 .. 11) of Unbounded_Wide_Wide_String;
   AktuelleSprachen : AktuelleSprachenArray;

   function AuswahlSprache
     return Unbounded_Wide_Wide_String;
   
private

   SchriftartFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
      
   ZehnerReihe : Natural;
   
   StartPositionYAchse : constant Float := 10.00;
   ZeilenAbstand : Float;
   Zeile : Float;
   TextPositionMaus : Float;
   
   Befehl : TastenbelegungDatentypen.Tastenbelegung_Enum;
   
   MehrSprachen : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => "+++++");
   
   TextAccess : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   MausZeigerPosition : Sf.System.Vector2.sfVector2i;
   
   procedure SprachenListeFestlegen;
   procedure MausAuswahl;
   
   
   
   function AuswahlMausTastatur
     return Unbounded_Wide_Wide_String;
         
   function AuswahlSpracheKonsole
     return Unbounded_Wide_Wide_String;

end AuswahlSprache;
