pragma Warnings (Off, "*array aggregate*");

with Sf.Audio;

with TonDatentypen;

package EingeleseneSounds is

   type SoundArray is array (TonDatentypen.AnzahlSounds'Range) of Sf.Audio.sfSoundBuffer_Ptr;
   Sound : SoundArray := (others => null);

end EingeleseneSounds;
