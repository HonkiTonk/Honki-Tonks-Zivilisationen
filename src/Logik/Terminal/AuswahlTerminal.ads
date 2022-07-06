pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package AuswahlTerminal is

   function AuswahlJaNeinTerminal
     (FrageZeileExtern : in Positive)
      return Boolean;

end AuswahlTerminal;
