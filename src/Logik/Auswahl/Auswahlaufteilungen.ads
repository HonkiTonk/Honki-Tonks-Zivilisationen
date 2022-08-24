pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with RueckgabeDatentypen;

package Auswahlaufteilungen is

   function AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return Boolean;
   
end Auswahlaufteilungen;
