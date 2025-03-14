with TonDatentypen;

with SchreibeSoundtask;

package body OftVerwendeterSound is

   procedure Klick
   is begin
      
      SchreibeSoundtask.SoundStarten (SoundExtern => TonDatentypen.Sound_Klick_Enum);
      
   end Klick;

end OftVerwendeterSound;
