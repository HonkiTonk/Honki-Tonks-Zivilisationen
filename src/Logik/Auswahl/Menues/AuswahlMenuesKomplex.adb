pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body AuswahlMenuesKomplex is

   function AuswahlMenüsKomplex
     (WelchesMenüExtern : in SystemDatentypen.Menü_Komplex_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Kartenform_Menü_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      -- Start_Weiter_Enum ist hier nur weil ich das Leer_Enum aus den Rückgabe_Werte_Enum entfernt habe.
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end AuswahlMenüsKomplex;

end AuswahlMenuesKomplex;
