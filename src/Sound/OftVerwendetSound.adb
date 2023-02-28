with TonDatentypen;

with NachSoundtask;

package body OftVerwendetSound is

   procedure Klick
   is begin
      
      NachSoundtask.SoundAbspielen := TonDatentypen.Sound_Klick_Enum;
      
   end Klick;

end OftVerwendetSound;
