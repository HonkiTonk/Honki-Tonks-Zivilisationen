pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.RectangleShape;
with Sf.System.Vector2;
with Sf.Graphics.Sprite;

with EinheitStadtDatentypen;
with EinheitStadtRecords;

package BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige;

private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   TextFestgelegt : Boolean := False;

   Zeilenabstand : Float;
   AbstandÜberschrift : Float;
   Multiplikator : Float;
   BreiteTextfeld : Float;

   ZusatztextGebäude : EinheitStadtDatentypen.GebäudeIDMitNullwert;
   ZusatztextEinheiten : EinheitStadtDatentypen.EinheitenIDMitNullWert;

   AktuellerTextbereichEins : Unbounded_Wide_Wide_String;
   AktuellerTextbereichZwei : Unbounded_Wide_Wide_String;

   AktuelleAuswahl : EinheitStadtRecords.BauprojektRecord;

   ÜberschriftAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   type GebäudetextAccessArray is array (EinheitStadtDatentypen.GebäudeIDMitNullwert'Range) of Sf.Graphics.sfText_Ptr;
   GebäudetextAccess : constant GebäudetextAccessArray := (others => Sf.Graphics.Text.create);

   type GebäudezusatztextAccessArray is array (EinheitStadtDatentypen.GebäudeID'Range) of Sf.Graphics.sfText_Ptr;
   GebäudezusatztextAccess : constant GebäudezusatztextAccessArray := (others => Sf.Graphics.Text.create);

   type EinheitentextAccessArray is array (EinheitStadtDatentypen.EinheitenIDMitNullWert'Range) of Sf.Graphics.sfText_Ptr;
   EinheitentextAccess : constant EinheitentextAccessArray := (others => Sf.Graphics.Text.create);

   type EinheitenzusatztextAccessArray is array (EinheitStadtDatentypen.EinheitenID'Range) of Sf.Graphics.sfText_Ptr;
   EinheitenzusatztextAccess : constant EinheitenzusatztextAccessArray := (others => Sf.Graphics.Text.create);

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   VerhältnisTextfeld : constant Sf.System.Vector2.sfVector2f := (0.48, 0.80);
   Grundposition : Sf.System.Vector2.sfVector2f;
   TextPosition : Sf.System.Vector2.sfVector2f;
   PositionHintergrund : Sf.System.Vector2.sfVector2f;

   procedure TextHintergrund
     (GebäudeEinheitExtern : in Boolean);



   function SchriftartFestlegen
     return Boolean;

   function SchriftgrößenFestlegen
     return Boolean;

   function SchriftfarbenFestlegen
     return Boolean;

   function TextFestlegen
     return Boolean;

end BauAuswahlAnzeigeSFML;
