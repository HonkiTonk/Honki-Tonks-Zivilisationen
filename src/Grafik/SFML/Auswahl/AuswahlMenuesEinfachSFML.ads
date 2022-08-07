pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

private with Sf.Graphics;
private with Sf.Graphics.Color;

with MenueDatentypen;

private with TextaccessVariablen;
private with GrafikRecords;

package AuswahlMenuesEinfachSFML is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  AuswahlMenüsEinfach'Result.x > 0.00
                and
                  AuswahlMenüsEinfach'Result.y > 0.00
               );

private

   Überschrift : constant Positive := TextaccessVariablen.Überschrift;
   Versionsnummer : constant Positive := TextaccessVariablen.Versionsnummer;

   Textbereich : Positive;

   HauptmenüAbzug : Natural;
   SchleifenAbzug : Natural;
   AktuelleEinstellung : Positive;

   AktuelleTextbreite : Float;
   NeueTextbreite : Float;
   PositionVersionsnummer : Float;

   Farbe : Sf.Graphics.Color.sfColor;

   StartpositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   Rechenwert : Sf.System.Vector2.sfVector2f;

   AktuelleAuswahlRückgabewert : GrafikRecords.AuswahlTextpositionRecord;
   Rückgabewert : GrafikRecords.AuswahlTextpositionRecord;

   procedure SchriftgrößenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure SchriftfarbenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure FarbeAktuelleEinstellungenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einstellung_Anzeigen_Enum);

   procedure FarbeAusgewählteRassenFestlegen;

   procedure FarbeAktuelleAuswahlFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural);

   procedure TextFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);



   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
      return GrafikRecords.AuswahlTextpositionRecord
     with
       Post => (
                  Textbearbeitung'Result.Textposition.x > 0.00
                and
                  Textbearbeitung'Result.Textposition.y > 0.00
               );

   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  TextpositionFestlegen'Result.x > 0.00
                and
                  TextpositionFestlegen'Result.y > 0.00
               );

end AuswahlMenuesEinfachSFML;
