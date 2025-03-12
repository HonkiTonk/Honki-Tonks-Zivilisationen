with Sf.Audio;

with TonDatentypen;

package EingeleseneSounds is
   pragma Elaborate_Body;

   type SoundbufferAccesseArray is array (TonDatentypen.Sound_Vorhanden_Enum'Range) of Sf.Audio.sfSoundBuffer_Ptr;
   SoundbufferAccesse : SoundbufferAccesseArray := (others => null);

   type SoundAccesseArray is array (SoundbufferAccesseArray'Range) of Sf.Audio.sfSound_Ptr;
   SoundAccesse : SoundAccesseArray := (others => null);

   procedure SoundsFestlegen;

end EingeleseneSounds;
