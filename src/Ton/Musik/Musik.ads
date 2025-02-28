private with TonDatentypen;

package Musik is
   pragma Elaborate_Body;

   procedure Musik;

private

   Musikart : TonDatentypen.Musikart_Enum;

   AktuelleMusik : Positive := 1;

   procedure Intro;
   procedure Spiel;
   procedure Forschung;
   procedure Pause;

end Musik;
