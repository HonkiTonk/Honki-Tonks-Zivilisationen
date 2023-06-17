with EinstellungenTon;

package body LeseEinstellungenTon is

   function Soundlautstärke
     return Float
   is begin
      
      return EinstellungenTon.Toneinstellungen.Soundlautstärke;
      
   end Soundlautstärke;
   
   
   
   function Musiklautstärke
     return Float
   is begin
      
      return EinstellungenTon.Toneinstellungen.Musiklautstärke;
      
   end Musiklautstärke;

end LeseEinstellungenTon;
