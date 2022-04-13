pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body AuswahlMenuesKomplex is

   function AuswahlMenüsKomplex
     (WelchesMenüExtern : in SystemDatentypen.Menü_Komplex_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Kartenform_Menü_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      return SystemDatentypen.Leer_Rückgabe_Enum;
      
   end AuswahlMenüsKomplex;

end AuswahlMenuesKomplex;
