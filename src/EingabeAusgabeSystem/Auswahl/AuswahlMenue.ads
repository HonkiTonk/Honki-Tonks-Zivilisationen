pragma SPARK_Mode (On);

with Sf.Graphics.Text;
with Sf.Graphics;
with Sf.System.Vector2;

with SystemDatentypen;

package AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü)
      return SystemDatentypen.Rückgabe_Werte_Enum;

private

   HauptmenüAnfang : constant Positive := 3;
   HauptmenüEnde : constant Positive := 8;

   AktuelleAuswahl : Positive;

   StartPositionYAchse : constant Float := 20.00;

   TextPositionMaus : Float;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   AktuellePosition : Sf.System.Vector2.sfVector2f;

   TextZugriff : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String);

   procedure AnzeigeHauptmenüSFML;
   procedure MausAuswahl;



   function Hauptmenü
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function TextMittelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float;

end AuswahlMenue;
