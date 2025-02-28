with Sf.Audio;

package StartEndeMusik is
   pragma Elaborate_Body;

   procedure Abspielen
     (MusikExtern : in Sf.Audio.sfMusic_Ptr);

   procedure Stoppen
     (MusikExtern : in Sf.Audio.sfMusic_Ptr);

   procedure Entfernen;

private

   procedure EntfernenVorgang
     (MusikExtern : in Sf.Audio.sfMusic_Ptr);

end StartEndeMusik;
