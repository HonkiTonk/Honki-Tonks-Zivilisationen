with Musiktask;

package body LeseMusiktask is

   function AktuelleMusikart
     return TonDatentypen.Musikart_Enum
   is begin
      
      return Musiktask.Musikart.AktuelleMusikart;
      
   end AktuelleMusikart;
   
   
   
   function NeueMusikart
     return TonDatentypen.Musikart_Enum
   is begin
      
      return Musiktask.Musikart.NeueMusikart;
      
   end NeueMusikart;

end LeseMusiktask;
