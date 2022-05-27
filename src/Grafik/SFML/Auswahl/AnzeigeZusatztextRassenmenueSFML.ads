pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf;
with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Sprite;

with RassenDatentypen;
with TextaccessVariablen;

package AnzeigeZusatztextRassenmenueSFML is

   procedure AnzeigeZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive);

private

   PositionFestgelegt : Boolean := False;
   TextFestgelegt : Boolean := False;

   RasseAnzeigen : RassenDatentypen.Rassen_Verwendet_Enum;

   LetzteRasse : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;

   SchleifenAnfang : Positive;
   SchleifenEnde : Positive;

   Zwischenwert : Integer;

   Multiplikator : Float;
   BreiteTextfeld : Float;

   AktuellerTextbereichEins : Unbounded_Wide_Wide_String;
   AktuellerTextbereichZwei : Unbounded_Wide_Wide_String;

   VerhältnisTextfeld : constant Sf.System.Vector2.sfVector2f := (0.48, 0.80);
   PositionHintergrund : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   type RassenTexteArray is array (TextaccessVariablen.ZusatztextRassenAccessArray'Range) of Unbounded_Wide_Wide_String;
   RassenTexte : RassenTexteArray;

   procedure TextHintergrund
     (AktuelleAuswahlExtern : in Positive);

   procedure Textbearbeitung
     (AktuelleRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure SchriftpositionFestlegen
     (AktuelleRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);



   function TextFestlegen
     return Boolean;

   function ZeilenumbruchEinbauen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
     with
       Post =>
         (ZeilenumbruchEinbauen'Result'Length > 0);

end AnzeigeZusatztextRassenmenueSFML;
