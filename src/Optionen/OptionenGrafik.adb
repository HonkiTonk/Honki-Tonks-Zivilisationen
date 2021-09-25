pragma SPARK_Mode (On);

with SystemKonstanten;

package body OptionenGrafik is

   function OptionenGrafik
     return Integer
   is begin
      
      return SystemKonstanten.ZurückKonstante;
      
   end OptionenGrafik;

end OptionenGrafik;
