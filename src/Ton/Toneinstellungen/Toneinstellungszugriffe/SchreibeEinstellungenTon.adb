with EinstellungenTon;

package body SchreibeEinstellungenTon is

   procedure Soundlautstärke
     (LautstärkeExtern : in Float)
   is begin
      
      EinstellungenTon.Toneinstellungen.Soundlautstärke := LautstärkeExtern;
      
   end Soundlautstärke;
   
   
   
   procedure Musiklautstärke
     (LautstärkeExtern : in Float)
   is begin
      
      EinstellungenTon.Toneinstellungen.Musiklautstärke := LautstärkeExtern;
            
   end Musiklautstärke;
   
   
   
   procedure GesamteToneinstellungen
     (EinstellungenExtern : in TonRecords.ToneinstellungenRecord)
   is begin
      
      EinstellungenTon.Toneinstellungen := EinstellungenExtern;
      
   end GesamteToneinstellungen;

end SchreibeEinstellungenTon;
