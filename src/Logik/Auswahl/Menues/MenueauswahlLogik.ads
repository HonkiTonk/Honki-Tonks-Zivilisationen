pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with RueckgabeDatentypen;

private with SystemKonstanten;

package MenueauswahlLogik is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Ohne_Steuerung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   Anfang : constant Positive := 1;
   Ende : Positive;

   AktuelleAuswahl : Natural := SystemKonstanten.LeerAuswahl;

   RechteMaustaste : constant Integer := -2;
   Ausgewählt : Integer;



   function Auswahl
     (WelchesMenüExtern : in MenueDatentypen.Menü_Ohne_Steuerung_Enum;
      EndeExtern : in Positive)
      return Integer;

end MenueauswahlLogik;
