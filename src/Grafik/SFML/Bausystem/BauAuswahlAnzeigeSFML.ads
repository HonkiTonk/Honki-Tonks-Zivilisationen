pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.RectangleShape;
with Sf.System.Vector2;
with Sf.Graphics.Sprite;

with EinheitStadtDatentypen;
with StadtRecords;

package BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige;

private

   SchriftgrößeFestgelegt : Boolean := False;

   Zeilenabstand : Float;
   AbstandÜberschrift : Float;
   Multiplikator : Float;
   BreiteTextfeld : Float;

   ZusatztextGebäude : EinheitStadtDatentypen.GebäudeIDMitNullwert;
   ZusatztextEinheiten : EinheitStadtDatentypen.EinheitenIDMitNullWert;

   AktuellerTextbereichEins : Unbounded_Wide_Wide_String;
   AktuellerTextbereichZwei : Unbounded_Wide_Wide_String;

   AktuelleAuswahl : StadtRecords.BauprojektRecord;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   VerhältnisTextfeld : constant Sf.System.Vector2.sfVector2f := (0.48, 0.80);
   Grundposition : Sf.System.Vector2.sfVector2f;
   TextPosition : Sf.System.Vector2.sfVector2f;
   PositionHintergrund : Sf.System.Vector2.sfVector2f;

   procedure TextHintergrund
     (GebäudeEinheitExtern : in Boolean);



   function SchriftgrößenFestlegen
     return Boolean;

end BauAuswahlAnzeigeSFML;
