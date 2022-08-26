pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with RueckgabeDatentypen;

private with SystemKonstanten;

package AuswahlMenuesEinfach is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   Anfang : constant Positive := 1;
   Ende : Positive;

   AktuelleAuswahl : Natural := SystemKonstanten.LeerAuswahl;

   RechteMaustaste : constant Integer := -2;
   Ausgewählt : Integer;

   Eins : Float;
   Zwei : Float;

   RückgabeWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;



   function Auswahl
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Integer
     with
       Pre => (
                 AnfangExtern <= EndeExtern
              );

end AuswahlMenuesEinfach;
