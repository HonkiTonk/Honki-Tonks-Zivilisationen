pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Audio;

with SystemDatentypen;

package EingeleseneSounds is

   type SoundArray is array (SystemDatentypen.Rassen_Enum'Range, 1 .. 10) of Sf.Audio.sfSoundBuffer_Ptr;
   Sound : SoundArray := (others => (others => null));

end EingeleseneSounds;
