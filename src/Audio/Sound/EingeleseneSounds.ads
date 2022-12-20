with Sf.Audio;

with TonDatentypen;

package EingeleseneSounds is
   pragma Elaborate_Body;

   type SoundArray is array (TonDatentypen.AnzahlSounds'Range) of Sf.Audio.sfSoundBuffer_Ptr;
   Sound : SoundArray := (others => null);

end EingeleseneSounds;
