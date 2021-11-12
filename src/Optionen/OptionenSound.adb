pragma SPARK_Mode (On);

with SystemKonstanten;

with AuswahlMenue;

package body OptionenSound is

   function OptionenSound
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SoundSchleife:
      loop
         
         AuswahlWert := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Sound_Menü);
         
         case
           AuswahlWert
         is  
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when others =>
               raise Program_Error;
         end case;
         
      end loop SoundSchleife;
      
   end OptionenSound;

end OptionenSound;
