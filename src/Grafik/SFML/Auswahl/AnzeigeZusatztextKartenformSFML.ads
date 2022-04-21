pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.System.Vector2;
with Sf.Graphics.Sprite;

package AnzeigeZusatztextKartenformSFML is

   procedure AnzeigeZusatztextKartenform
     (AktuelleAuswahlExtern : in Positive);

   procedure SchriftartZurücksetzen;
   procedure TextZurücksetzen;
   procedure SchriftgrößeZurücksetzen;

private

   LeerFestgelegt : constant Boolean := False;
   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   PositionFestgelegt : Boolean := False;
   TextFestgelegt : Boolean := False;

   LetzteAuswahl : Natural := 0;

   Multiplikator : Float;
   BreiteTextfeld : Float;

   AktuellerTextbereichEins : Unbounded_Wide_Wide_String;
   AktuellerTextbereichZwei : Unbounded_Wide_Wide_String;

   VerhältnisTextfeld : constant Sf.System.Vector2.sfVector2f := (0.48, 0.80);
   PositionHintergrund : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   type TextAccessArray is array (1 .. 10) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (
                                             others => Sf.Graphics.Text.create
                                            );

   procedure TextHintergrund
     (AktuelleAuswahlExtern : in Positive);

   procedure Textbearbeitung
     (AktuelleAuswahlExtern : in Positive);

   procedure SchriftpositionFestlegen
     (AktuelleAuswahlExtern : in Positive);



   function SchriftartFestlegen
     return Boolean;

   function SchriftfarbeFestlegen
     return Boolean;

   function SchriftgrößeFestlegen
     return Boolean;

   function TextFestlegen
     return Boolean;

end AnzeigeZusatztextKartenformSFML;
