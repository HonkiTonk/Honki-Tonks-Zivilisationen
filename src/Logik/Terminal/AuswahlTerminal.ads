pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package AuswahlTerminal is

   function AuswahlJaNeinTerminal
     (FrageZeileExtern : in Positive)
      return RueckgabeDatentypen.Ja_Nein_Enum;

end AuswahlTerminal;
