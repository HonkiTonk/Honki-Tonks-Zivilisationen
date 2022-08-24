pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

with MenueDatentypen;

private with TextKonstanten;

package AuswahlMenuesEinfachSFML is

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Integer);

private

   Textarrayanpassung : constant Positive := 2;

   AktuelleEinstellung : Natural;

   Textbreite : Float;

   -- Für die Viewfläche mal einen eigenen Wert in den GrafikRecordKonstanten anlegen?
   Viewfläche : Sf.System.Vector2.sfVector2f := TextKonstanten.StartpositionText;
   Textposition : Sf.System.Vector2.sfVector2f;
   Rechenwert : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;

   procedure FarbeFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      AktuellerTextExtern : in Positive);



   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Integer)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Textbearbeitung'Result.x >= 0.00
                and
                  Textbearbeitung'Result.y >= 0.00
               );

   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Integer)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  TextpositionFestlegen'Result.x > 0.00
                and
                  TextpositionFestlegen'Result.y > 0.00
               );

end AuswahlMenuesEinfachSFML;
