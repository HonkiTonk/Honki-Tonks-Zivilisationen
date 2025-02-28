with Musiktask;

package body SchreibeMusiktask is

   procedure AktuelleMusikart
     (MusikExtern : in TonDatentypen.Musikart_Enum)
   is begin
      
      Musiktask.Musikart.AktuelleMusikart := MusikExtern;
      
   end AktuelleMusikart;
   
   
   
   procedure NeueMusikart
     (MusikExtern : in TonDatentypen.Musikart_Enum)
   is begin
      
      Musiktask.Musikart.NeueMusikart := MusikExtern;
      
   end NeueMusikart;

end SchreibeMusiktask;
