pragma SPARK_Mode (On);

with SystemKonstanten;

package body OptionenSound is

   function OptionenSound
     return Integer
   is begin
      
      return SystemKonstanten.ZurückKonstante;
      
   end OptionenSound;

end OptionenSound;
