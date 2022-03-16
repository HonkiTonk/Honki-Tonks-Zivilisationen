pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics;
with Sf.System.Vector2;

with SystemDatentypen;

package AuswahlMenue is

   WelchesMenü : SystemDatentypen.Welches_Menü_Enum;

   Anfang : Positive;
   Ende : Positive;
   AktuelleAuswahl : Positive := 1;

   AnzeigeStartwert : Natural;

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function StringSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return Wide_Wide_String;

private

   StartPositionYAchse : constant Float := 10.00;
   ZeilenAbstand : Float;

   LetztesMenü : SystemDatentypen.Welches_Menü_Enum := SystemDatentypen.Haupt_Menü_Enum;

   RückgabeWert : SystemDatentypen.Rückgabe_Werte_Enum;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   TextPositionMaus : Sf.System.Vector2.sfVector2f;

   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   type AnfangEndeMenüArray is array (SystemDatentypen.Welches_Menü_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Positive;
   AnfangEndeMenü : constant AnfangEndeMenüArray := (
                                                       SystemDatentypen.Haupt_Menü_Enum              => (3, 9),
                                                       SystemDatentypen.Spiel_Menü_Enum              => (2, 7),
                                                       SystemDatentypen.Optionen_Menü_Enum           => (2, 8),
                                                       SystemDatentypen.Kartengröße_Menü_Enum        => (2, 16),
                                                       SystemDatentypen.Kartenart_Menü_Enum          => (2, 10),
                                                       SystemDatentypen.Kartenform_Menü_Enum         => (2, 14),
                                                       SystemDatentypen.Kartentemperatur_Menü_Enum   => (2, 10),
                                                       SystemDatentypen.Kartenressourcen_Menü_Enum   => (2, 10),
                                                       SystemDatentypen.Schwierigkeitsgrad_Menü_Enum => (2, 8),
                                                       SystemDatentypen.Rassen_Menü_Enum             => (2, 24),
                                                       SystemDatentypen.Grafik_Menü_Enum             => (2, 8),
                                                       SystemDatentypen.Sound_Menü_Enum              => (2, 4),
                                                       SystemDatentypen.Steuerung_Menü_Enum          => (2, 46),
                                                       SystemDatentypen.Sonstiges_Menü_Enum          => (2, 7),
                                                       SystemDatentypen.Editoren_Menü_Enum           => (2, 9)
                                                      );

   procedure MausAuswahl;
   procedure Auswahl;

   procedure AllgemeinesFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum);

end AuswahlMenue;
