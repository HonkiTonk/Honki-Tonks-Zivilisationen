with Sf.Audio;

package StartEndeMusik is
   pragma Elaborate_Body;

   procedure Abspielen
     (MusikExtern : in Sf.Audio.sfMusic_Ptr);

   procedure Stoppen;
   procedure Entfernen;

end StartEndeMusik;
