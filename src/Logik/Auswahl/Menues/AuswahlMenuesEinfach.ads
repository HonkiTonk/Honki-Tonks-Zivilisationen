pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with MenueDatentypen;
with RueckgabeDatentypen;
with SystemKonstanten;

package AuswahlMenuesEinfach is

   AktuelleAuswahl : Natural := SystemKonstanten.LeerAuswahl;



   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   Anfang : constant Positive := 1;
   Ende : Positive;
   Ausgewählt : Natural;

   Eins : Float;
   Zwei : Float;

   RückgabeWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   Mausposition : Sf.System.Vector2.sfVector2f;

   function Auswahl
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
     with
       Pre => (
                 AnfangExtern <= EndeExtern
              );

   function MausAuswahl
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
     with
       Pre => (
                 AnfangExtern <= EndeExtern
              );

end AuswahlMenuesEinfach;
