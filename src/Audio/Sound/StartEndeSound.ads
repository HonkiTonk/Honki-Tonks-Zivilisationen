pragma Warnings (Off, "*array aggregate*");

private with Sf.Audio;
private with Sf.Audio.Sound;

package StartEndeSound is

   procedure Abspielen;
   procedure Stoppen;
   procedure Entfernen;

private

   SoundTest : constant Sf.Audio.sfSound_Ptr := Sf.Audio.Sound.create;

end StartEndeSound;
