pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with SystemDatentypen;

package AuswahlMenuesEinfach is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

private

   Anfang : Positive;
   Ende : Positive;
   Ausgewählt : Positive;

   AktuelleAuswahl : Natural := 1;
   AnfangAbzug : Natural;
   EndeAbzug : Natural;

   RückgabeWert : SystemDatentypen.Rückgabe_Werte_Enum;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   function Auswahl
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
      return Positive;

   function MausAuswahl
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
      return Natural;

end AuswahlMenuesEinfach;
