pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;
private with Sf.Graphics;
private with Sf.Graphics.Color;

with MenueDatentypen;

private with TextaccessVariablen;

package AuswahlMenuesEinfachSFML is

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum);

private

   Überschrift : constant Positive := TextaccessVariablen.Überschrift;
   Versionsnummer : constant Positive := TextaccessVariablen.Versionsnummer;

   Textbereich : Positive;

   HauptmenüAbzug : Natural;
   SchleifenAbzug : Natural;
   AktuelleAuswahl : Natural;
   AktuelleAuswahlRückgabewert : Natural;
   AktuelleEinstellung : Positive;

   Farbe : Sf.Graphics.Color.sfColor;

   Rechenwert : Sf.System.Vector2.sfVector2f;



   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
      return Natural;

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

   procedure SchriftpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure TextFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

end AuswahlMenuesEinfachSFML;
