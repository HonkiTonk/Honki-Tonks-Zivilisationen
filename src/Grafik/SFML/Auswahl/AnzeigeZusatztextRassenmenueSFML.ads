pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf;
with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Text;
with Sf.Graphics.Sprite;

with RassenDatentypen;

package AnzeigeZusatztextRassenmenueSFML is

   procedure AnzeigeZusatztextRassenmenü
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

   RasseAnzeigen : RassenDatentypen.Rassen_Verwendet_Enum;

   LetzteRasse : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;

   Multiplikator : Float;
   BreiteTextfeld : Float;

   AktuellerTextbereichEins : Unbounded_Wide_Wide_String;
   AktuellerTextbereichZwei : Unbounded_Wide_Wide_String;

   VerhältnisTextfeld : constant Sf.System.Vector2.sfVector2f := (0.48, 0.80);
   PositionHintergrund : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   type TextAccessArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (
                                             others => Sf.Graphics.Text.create
                                            );

   type RassenTexteArray is array (TextAccessArray'Range) of Unbounded_Wide_Wide_String;
   RassenTexte : RassenTexteArray;

   procedure TextHintergrund
     (AktuelleAuswahlExtern : in Positive);

   procedure Textbearbeitung
     (AktuelleRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure SchriftpositionFestlegen
     (AktuelleRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);



   function SchriftartFestlegen
     return Boolean;

   function SchriftfarbeFestlegen
     return Boolean;

   function SchriftgrößeFestlegen
     return Boolean;

   function TextFestlegen
     return Boolean;

end AnzeigeZusatztextRassenmenueSFML;
