pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with MenueDatentypen;

package AuswahlMenuesStringsSetzen is

   function AuswahlMenüEinfachStringSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return Wide_Wide_String;
   
   function AuswahlMenüZusatztextStringSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Enum)
      return Wide_Wide_String;
   
private
   
   AktuellerText : Unbounded_Wide_Wide_String;

end AuswahlMenuesStringsSetzen;
