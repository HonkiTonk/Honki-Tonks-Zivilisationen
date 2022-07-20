pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Graphics;
private with Sf.Graphics.RectangleShape;
private with Sf.System.Vector2;
private with Sf.Graphics.Sprite;

with RassenDatentypen;
private with StadtDatentypen;
private with EinheitenDatentypen;
private with StadtRecords;
private with MenueDatentypen;

package BauAuswahlAnzeigeSFML is

   -- Hier später KORREKTEN Contract hinzufügen. äöü
   procedure BauAuswahlAnzeige
     (RasseExtern : in RassenDatentypen.Rassen_Enum);

private

   SchriftgrößeFestgelegt : Boolean := False;

   AbstandÜberschrift : Float;
   Multiplikator : Float;
   BreiteTextfeld : Float;

   Hintergrund : MenueDatentypen.Welches_Menü_Vorhanden_Enum;

   ZusatztextGebäude : StadtDatentypen.GebäudeIDMitNullwert;
   ZusatztextEinheiten : EinheitenDatentypen.EinheitenIDMitNullWert;

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
