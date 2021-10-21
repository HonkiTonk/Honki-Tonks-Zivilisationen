pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;
with Sf.System.Vector2;

with SystemDatentypen;

package AuswahlSprache is

   function AuswahlSprache
     return Unbounded_Wide_Wide_String;
   
private

   AktuelleAuswahl : Positive;
   Ende : Positive;
   LängsterText : Positive;
   
   ZehnerReihe : Natural;
   
   StartPositionYAchse : constant Float := 20.00;
   ZeilenAbstand : Float;
   Zeile : Float;
   
   AktuelleTextFarbe : Sf.Graphics.Color.sfColor;
   
   TextZugriff : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   MausZeigerPosition : Sf.System.Vector2.sfVector2i;
   
   MehrSprachen : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => "++++++++++");
   
   type AktuelleSprachenArray is array (1 .. 11) of Unbounded_Wide_Wide_String;
   AktuelleSprachen : AktuelleSprachenArray;

   procedure AnzeigeSpracheKonsole
     (AktuelleAuswahlExtern : in Positive;
      LetzteZeileExtern : in Positive);
   
   procedure AnzeigeSpracheSFML
     (AktuelleAuswahlExtern : in Positive;
      LetzteZeileExtern : in Positive);
   
   procedure SprachenListeFestlegen;
   
   
   
   function AuswahlMausTastatur
     return Unbounded_Wide_Wide_String;
         
   function AuswahlSpracheKonsole
     return Unbounded_Wide_Wide_String;
   
   function AuswahlSpracheSFML
     (AnzeigeArtExtern : in SystemDatentypen.Anzeige_Art_Grafik_Enum)
      return Unbounded_Wide_Wide_String;

end AuswahlSprache;
