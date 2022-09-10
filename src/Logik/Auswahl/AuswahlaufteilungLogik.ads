pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with RueckgabeDatentypen;

package AuswahlaufteilungLogik is

   function AuswahlMenüsAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
private
   
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
end AuswahlaufteilungLogik;
