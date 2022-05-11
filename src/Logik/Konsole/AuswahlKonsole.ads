pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package AuswahlKonsole is

   function AuswahlJaNeinKonsole
     (FrageZeileExtern : in Positive)
      return RueckgabeDatentypen.Ja_Nein_Enum;

end AuswahlKonsole;
