pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package Auswahl is

   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return Boolean;
   
end Auswahl;
