pragma SPARK_Mode (On);

with Sf.Audio;
with Sf.Audio.Sound;

package SoundSFML is

   procedure SoundSFML;

private

   SoundTest : constant Sf.Audio.sfSound_Ptr := Sf.Audio.Sound.create;

end SoundSFML;
