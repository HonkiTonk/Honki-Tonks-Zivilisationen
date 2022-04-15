pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with RueckgabeDatentypen;

package AuswahlMenues is

   function AuswahlMenüsAufteilung
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

end AuswahlMenues;
