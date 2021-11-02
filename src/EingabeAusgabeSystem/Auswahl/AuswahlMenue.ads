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
                                                       SystemDatentypen.Spiel_Menü => (2, 7),
                                                       SystemDatentypen.Optionen_Menü => (2, 8),
                                                       SystemDatentypen.Kartengröße_Menü => (2, 14),
                                                       SystemDatentypen.Kartenart_Menü => (2, 9),
                                                       SystemDatentypen.Kartenform_Menü => (2, 13),
                                                       SystemDatentypen.Kartentemperatur_Menü => (2, 10),
                                                       SystemDatentypen.Kartenressourcen_Menü => (2, 9),
                                                       SystemDatentypen.Schwierigkeitsgrad_Menü => (2, 8),
                                                       SystemDatentypen.Spieleranzahl_Menü => (2, 6),
                                                       SystemDatentypen.Rassen_Menü => (2, 23)
                                                      );

   Anfang : Positive;
   Ende : Positive;
   AktuelleAuswahl : Positive;

   StartPositionYAchse : constant Float := 20.00;

   TextPositionMaus : Float;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   AktuellePosition : Sf.System.Vector2.sfVector2f;

   TextZugriff : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   procedure Überschrift;

   procedure StringSetzen
     (WelcheZeileExtern : in Positive);

   procedure AnzeigeMenüSFML;
   procedure MausAuswahl;
   procedure Auswahl;



   function Hauptmenü
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function Spielmenü
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function Optionsmenü
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartengrößeAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartenartAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartenformAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartentemperaturAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function KartenRessourcenAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function SchwierigkeitsgradAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function SpieleranzahlAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function RasseAuswählen
     return SystemDatentypen.Rückgabe_Werte_Enum;

   function TextMittelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float;

end AuswahlMenue;
