pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body OptionenSound is

   function OptionenSound
     return Integer
   is begin
      
      return GlobaleKonstanten.ZurückKonstante;
      
   end OptionenSound;

end OptionenSound;
