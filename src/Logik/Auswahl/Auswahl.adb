pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
-- with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;
-- with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

-- with TastenbelegungDatentypen;

-- with TextAnzeigeKonsole;
-- with Eingabe;

package body Auswahl is
   
   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
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
      
   end AuswahlJaNein;

end Auswahl;
