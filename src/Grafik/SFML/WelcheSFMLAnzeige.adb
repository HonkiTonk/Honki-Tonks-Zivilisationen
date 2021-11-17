pragma SPARK_Mode (On);

package body WelcheSFMLAnzeige is

   procedure WelcheSFMLAnzeige
   is begin
      
      AktuelleDarstellung := SystemDatentypen.SFML_Start;
      
      GrafikSchleife:
      loop
      
         case
           AktuelleDarstellung
         is
            when SystemDatentypen.Konsole =>
               return;
            
            when SystemDatentypen.SFML_Start =>
               null;
            
            when SystemDatentypen.SFML_Intro =>
               null;
               
            when SystemDatentypen.SFML_Hauptmenü =>
               null;
            
            when SystemDatentypen.SFML_Ende =>
               return;
         end case;
         
      end loop GrafikSchleife;
      
   end WelcheSFMLAnzeige;

end WelcheSFMLAnzeige;
