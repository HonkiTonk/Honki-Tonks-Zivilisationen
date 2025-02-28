with Soundtask;

package body SchreibeSoundtask is

   procedure SoundStarten
     (SoundExtern : in TonDatentypen.Sound_Enum)
   is begin
      
      Soundtask.Sound.Starten := SoundExtern;
      
   end SoundStarten;
   
   
   
   procedure SoundStoppen
     (SoundExtern : in TonDatentypen.Sound_Enum)
   is begin
      
      Soundtask.Sound.Stoppen := SoundExtern;
      
   end SoundStoppen;

end SchreibeSoundtask;
