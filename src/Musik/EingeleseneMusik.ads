with Sf.Audio;

with SpeziesDatentypen;
with TonDatentypen;

package EingeleseneMusik is
   pragma Elaborate_Body;

   type MusikArray is array (SpeziesDatentypen.Spezies_Enum'Range, TonDatentypen.AnzahlLieder'Range) of Sf.Audio.sfMusic_Ptr;
   Musik : MusikArray := (others => (others => null));

end EingeleseneMusik;
