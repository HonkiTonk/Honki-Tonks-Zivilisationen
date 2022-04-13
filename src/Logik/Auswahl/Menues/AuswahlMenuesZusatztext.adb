pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body AuswahlMenuesZusatztext is

   function AuswahlMenüsZusatztext
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Kartengröße_Menü_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      return SystemDatentypen.Leer_Rückgabe_Enum;
      
   end AuswahlMenüsZusatztext;

end AuswahlMenuesZusatztext;
