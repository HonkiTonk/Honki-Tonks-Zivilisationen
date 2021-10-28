pragma SPARK_Mode (On);

package body AuswahlMenue is

   function AuswahlMenü
     (WelchesMenüExtern : in SystemDatentypen.Welches_Menü)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Hauptmenü =>
            return SystemDatentypen.Start_Weiter;
            
         when others =>
            return SystemDatentypen.Start_Weiter;
      end case;
      
   end AuswahlMenü;

end AuswahlMenue;
