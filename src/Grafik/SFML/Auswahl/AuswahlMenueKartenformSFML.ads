pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;
with Sf.Graphics.Color;

with MenueDatentypen;

package AuswahlMenueKartenformSFML is

   function AuswahlMenüKartenform
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  AuswahlMenüKartenform'Result.x >= 0.00
                and
                  AuswahlMenüKartenform'Result.y >= 0.00
               );

private

   Textarrayanpassung : constant Positive := 2;
   WelcherZusatztext : Positive;

   Textbreite : Float;

   Zusatztext : Unbounded_Wide_Wide_String;

   Textposition : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;

   procedure FarbenFestlegen
     (AktuellerTextExtern : in Positive;
      AktuelleAuswahlExtern : in Natural);



   function TextEinlesen
     (SchleifenwertExtern : in Positive)
      return Wide_Wide_String;

end AuswahlMenueKartenformSFML;
