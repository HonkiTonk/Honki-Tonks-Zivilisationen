with Sf.Audio.SoundStatus;
with Sf.Audio.Sound;
with Sf.Audio.SoundBuffer;

with SchreibeSoundtask;

with EingeleseneSounds;

package body StartEndeSound is

   -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
   procedure Abspielen
     (SoundExtern : in TonDatentypen.Sound_Vorhanden_Enum)
   is
      use type Sf.Audio.sfSoundBuffer_Ptr;
      use type Sf.Audio.SoundStatus.sfSoundStatus;
      use type Sf.Audio.sfSound_Ptr;
   begin
      
      if
        EingeleseneSounds.SoundbufferAccesse (SoundExtern) = null
      then
         null;
         
      elsif
        EingeleseneSounds.SoundAccesse (SoundExtern) = null
      then
         null;
         
      elsif
        Sf.Audio.Sound.getStatus (sound => EingeleseneSounds.SoundAccesse (SoundExtern)) = Sf.Audio.SoundStatus.sfPlaying
      then
         null;
         
      else
         Sf.Audio.Sound.play (sound => EingeleseneSounds.SoundAccesse (SoundExtern));
      end if;
      
   end Abspielen;
   
   
   
   procedure Stoppen
     (SoundExtern : in TonDatentypen.Sound_Vorhanden_Enum)
   is
      use type Sf.Audio.sfSoundBuffer_Ptr;
      use type Sf.Audio.sfSound_Ptr;
      use type Sf.Audio.SoundStatus.sfSoundStatus;
   begin
      
      if
        EingeleseneSounds.SoundbufferAccesse (SoundExtern) = null
      then
         null;
         
      elsif
        EingeleseneSounds.SoundAccesse (SoundExtern) = null
      then
         null;
         
      elsif
        Sf.Audio.Sound.getStatus (sound => EingeleseneSounds.SoundAccesse (SoundExtern)) = Sf.Audio.SoundStatus.sfPlaying
      then
         Sf.Audio.Sound.stop (sound => EingeleseneSounds.SoundAccesse (SoundExtern));
         
      else
         null;
      end if;
      
   end Stoppen;
   
   
   
   procedure TaskStoppen
   is begin
      
      SchreibeSoundtask.SoundStarten (SoundExtern => TonDatentypen.Sound_Ende_Enum);
      SchreibeSoundtask.SoundStoppen (SoundExtern => TonDatentypen.Sound_Ende_Enum);
      
   end TaskStoppen;
   
   
   
   procedure Entfernen
   is begin
            
      SoundSchleife:
      for SoundSchleifenwert in EingeleseneSounds.SoundAccesseArray'Range loop
         
         -- Das hier ist notwendig um die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms zu verhindern.
         Sf.Audio.SoundBuffer.destroy (soundBuffer => EingeleseneSounds.SoundbufferAccesse (SoundSchleifenwert));
         Sf.Audio.Sound.destroy (sound => EingeleseneSounds.SoundAccesse (SoundSchleifenwert));
         
      end loop SoundSchleife;
      
   end Entfernen;

end StartEndeSound;
