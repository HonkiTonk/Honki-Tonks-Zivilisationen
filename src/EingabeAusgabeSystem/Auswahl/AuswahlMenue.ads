pragma SPARK_Mode (On);

with Sf.Graphics.Text;
with Sf.Graphics;
with Sf.System.Vector2;

with SystemDatentypen;

package AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

private

   WelchesMenü : SystemDatentypen.Welches_Menü_Enum;

   type AnfangEndeMenüArray is array (SystemDatentypen.Welches_Menü_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Positive;
   AnfangEndeMenü : constant AnfangEndeMenüArray := (
                                                       SystemDatentypen.Haupt_Menü => (3, 8),
                                                       SystemDatentypen.Spiel_Menü => (1, 1),
                                                       SystemDatentypen.Optionen_Menü => (1, 1),
                                                       SystemDatentypen.Kartengröße_Menü => (1, 1),
                                                       SystemDatentypen.Kartenart_Menü => (1, 1)
                                                      );

   Anfang : Positive;
   Ende : Positive;
   AktuelleAuswahl : Positive;

   StartPositionYAchse : constant Float := 20.00;

   TextPositionMaus : Float;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   AktuellePosition : Sf.System.Vector2.sfVector2f;

   TextZugriff : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String);

   procedure StringSetzen
     (WelcheZeileExtern : in Positive);

   procedure AnzeigeMenüSFML;
   procedure MausAuswahl;



   function Hauptmenü
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function TextMittelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float;

end AuswahlMenue;
