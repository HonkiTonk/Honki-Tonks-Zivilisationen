pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body OptionenGrafik is

   function OptionenGrafik
     return Integer
   is begin
      
      return GlobaleKonstanten.ZurückKonstante;
      
   end OptionenGrafik;

end OptionenGrafik;
