pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body AuswahlTerminal is

   function AuswahlJaNeinTerminal
     (FrageZeileExtern : in Positive)
      return RueckgabeDatentypen.Ja_Nein_Enum
   is begin
      
      case
        FrageZeileExtern
      is
         when 1 =>
            null;
            
         when others =>
            null;
      end case;
      
      return RueckgabeDatentypen.Ja_Enum;
      
   end AuswahlJaNeinTerminal;

end AuswahlTerminal;