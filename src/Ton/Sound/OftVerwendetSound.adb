with TonDatentypen;

with SchreibeSoundtask;

package body OftVerwendetSound is

   procedure Klick
   is begin
      
      SchreibeSoundtask.SoundStarten (SoundExtern => TonDatentypen.Sound_Klick_Enum);
      
   end Klick;

end OftVerwendetSound;
