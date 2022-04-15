pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with SystemDatentypen;
with RueckgabeDatentypen;
with SystemKonstanten;

package AuswahlMenuesEinfach is

   AktuelleAuswahl : Natural := SystemKonstanten.LeerAuswahl;



   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   Anfang : constant Positive := 1;
   Ende : Positive;
   Ausgewählt : Positive;

   RückgabeWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   function Auswahl
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Positive;

   function MausAuswahl
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural;

end AuswahlMenuesEinfach;
