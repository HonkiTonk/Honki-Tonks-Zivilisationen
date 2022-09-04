pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;
with Sf.Graphics.Color;

with MenueDatentypen;

package KartenformmenueGrafik is

   function Kartenformmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Kartenformmenü'Result.x >= 0.00
                and
                  Kartenformmenü'Result.y >= 0.00
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

end KartenformmenueGrafik;
