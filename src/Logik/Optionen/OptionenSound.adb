pragma SPARK_Mode (On);

with SystemKonstanten;

with AuswahlMenue;
with Fehler;

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
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSound.OptionenSound - Ungültige Menüauswahl.");
         end case;
         
      end loop SoundSchleife;
      
   end OptionenSound;

end OptionenSound;
