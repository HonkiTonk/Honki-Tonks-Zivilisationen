pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body AuswahlTerminal is

   function AuswahlJaNeinTerminal
     (FrageZeileExtern : in Positive)
      return Boolean
   is begin
      
      case
        FrageZeileExtern
      is
         when 1 =>
            null;
            
         when others =>
            null;
      end case;
      
      return True;
      
   end AuswahlJaNeinTerminal;

end AuswahlTerminal;
