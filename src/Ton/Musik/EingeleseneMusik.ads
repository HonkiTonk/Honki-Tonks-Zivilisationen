with Sf.Audio;

with TonDatentypen;

package EingeleseneMusik is
   pragma Elaborate_Body;

   type MusikArray is array (TonDatentypen.AnzahlLieder'Range) of Sf.Audio.sfMusic_Ptr;
   Musik : MusikArray := (others => null);

end EingeleseneMusik;
