pragma SPARK_Mode (On);

with SystemKonstanten;

package body OptionenSound is

   function OptionenSound
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      return SystemKonstanten.ZurückKonstante;
      
   end OptionenSound;

end OptionenSound;
