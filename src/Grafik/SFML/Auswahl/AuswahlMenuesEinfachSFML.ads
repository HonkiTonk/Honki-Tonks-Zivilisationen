pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

private with Sf.Graphics;
private with Sf.Graphics.Color;

with MenueDatentypen;

private with GrafikRecords;

package AuswahlMenuesEinfachSFML is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x > 0.00
               and
                 ViewflächeExtern.y > 0.00
              ),

       Post => (
                  AuswahlMenüsEinfach'Result.x > 0.00
                and
                  AuswahlMenüsEinfach'Result.y > 0.00
               );

private

   StartpunktTextschleifen : constant Positive := 2;
   AktuelleEinstellung : Positive;
   Ende : Positive;

   PositionVersionsnummer : Float;
   AktuelleTextbreite : Float;

   Farbe : Sf.Graphics.Color.sfColor;

   Rechenwert : Sf.System.Vector2.sfVector2f;

   AktuelleAuswahlRückgabewert : GrafikRecords.AuswahlTextpositionRecord;
   Rückgabewert : GrafikRecords.AuswahlTextpositionRecord;

   procedure SchriftfarbenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure FarbeAktuelleEinstellungenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einstellung_Anzeigen_Enum;
      TextbereichExtern : in Positive);

   procedure FarbeAusgewählteRassenFestlegen
     (TextbereichExtern : in Positive);

   procedure FarbeAktuelleAuswahlFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural);



   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return GrafikRecords.AuswahlTextpositionRecord
     with
       Post => (
                  Textbearbeitung'Result.Textposition.x > 0.00
                and
                  Textbearbeitung'Result.Textposition.y > 0.00
               );

   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  TextpositionFestlegen'Result.x > 0.00
                and
                  TextpositionFestlegen'Result.y > 0.00
               );

end AuswahlMenuesEinfachSFML;
