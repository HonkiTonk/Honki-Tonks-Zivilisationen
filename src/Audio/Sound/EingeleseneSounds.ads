with Sf.Audio;
with Sf.Audio.Sound;

with TonDatentypen;

package EingeleseneSounds is
   pragma Elaborate_Body;

   type SoundArray is array (TonDatentypen.Sound_Vorhanden_Enum'Range) of Sf.Audio.sfSoundBuffer_Ptr;
   Sound : SoundArray := (others => null);

   type SoundaccesseArray is array (SoundArray'Range) of Sf.Audio.sfSound_Ptr;
   Soundaccesse : constant SoundaccesseArray := (others => Sf.Audio.Sound.create);

   procedure SoundsFestlegen;

end EingeleseneSounds;
