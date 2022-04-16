pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Audio;

with RassenDatentypen;
with TonDatentypen;

package EingeleseneSounds is

   type SoundArray is array (RassenDatentypen.Rassen_Enum'Range, TonDatentypen.AnzahlSounds'Range) of Sf.Audio.sfSoundBuffer_Ptr;
   Sound : SoundArray := (others => (others => null));

end EingeleseneSounds;
