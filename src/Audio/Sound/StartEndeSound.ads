private with Sf.Audio;
private with Sf.Audio.Sound;

package StartEndeSound is
   pragma Elaborate_Body;

   procedure Abspielen;
   procedure Stoppen;
   procedure Entfernen;

private

   SoundTest : constant Sf.Audio.sfSound_Ptr := Sf.Audio.Sound.create;

end StartEndeSound;
