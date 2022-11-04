pragma Warnings (Off, "*array aggregate*");

with Sf.Audio;

with RassenDatentypen;
with TonDatentypen;

package EingeleseneMusik is

   type MusikArray is array (RassenDatentypen.Rassen_Enum'Range, TonDatentypen.AnzahlLieder'Range) of Sf.Audio.sfMusic_Ptr;
   Musik : MusikArray := (others => (others => null));

end EingeleseneMusik;
