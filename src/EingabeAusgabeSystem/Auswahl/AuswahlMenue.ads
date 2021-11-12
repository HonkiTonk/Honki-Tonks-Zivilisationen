pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

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
                                                       SystemDatentypen.Spiel_Menü => (2, 7),
                                                       SystemDatentypen.Optionen_Menü => (2, 8),
                                                       SystemDatentypen.Kartengröße_Menü => (2, 15),
                                                       SystemDatentypen.Kartenart_Menü => (2, 10),
                                                       SystemDatentypen.Kartenform_Menü => (2, 13),
                                                       SystemDatentypen.Kartentemperatur_Menü => (2, 10),
                                                       SystemDatentypen.Kartenressourcen_Menü => (2, 9),
                                                       SystemDatentypen.Schwierigkeitsgrad_Menü => (2, 8),
                                                       SystemDatentypen.Rassen_Menü => (2, 24),
                                                       SystemDatentypen.Grafik_Menü => (2, 7),
                                                       SystemDatentypen.Sound_Menü => (2, 4),
                                                       SystemDatentypen.Steuerung_Menü => (2, 46),
                                                       SystemDatentypen.Sonstiges_Menü => (2, 7)
                                                      );

   Anfang : Positive;
   Ende : Positive;
   AktuelleAuswahl : Positive := 1;
   RassenBelegt : Positive;
   RassenBelegtZähler : Positive;
   LetztesZeichen : Positive;
   ErstesZeichen : Positive;

   AnzeigeStartwert : Natural;

   StartPositionYAchse : constant Float := 10.00;
   ZeilenAbstand : Float;
   XPosition : Float;

   AktuellerText : Unbounded_Wide_Wide_String;

   LetztesMenü : SystemDatentypen.Welches_Menü_Enum := SystemDatentypen.Haupt_Menü;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   AktuellePosition : Sf.System.Vector2.sfVector2f;
   TextPositionMaus : Sf.System.Vector2.sfVector2f;

   TextZugriff : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   procedure Überschrift;

   procedure StringSetzen
     (WelcheZeileExtern : in Positive);

   procedure AnzeigeMenüSFML;
   procedure MausAuswahl;
   procedure Auswahl;
   procedure WeiterenTextAnzeigen;

   procedure AnzeigeFarbeBestimmen
     (TextZeileExtern : in Positive);

   procedure AllgemeinesFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum);

end AuswahlMenue;
