pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package AuswahlSFML is

   function AuswahlJaNeinSFML
     (FrageZeileExtern : in Positive)
      return RueckgabeDatentypen.Ja_Nein_Enum;

end AuswahlSFML;
