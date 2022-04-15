pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Audio;

with RueckgabeDatentypen;

package EingeleseneMusik is

   type MusikArray is array (RueckgabeDatentypen.Rassen_Enum'Range, 1 .. 5) of Sf.Audio.sfMusic_Ptr;
   Musik : MusikArray := (others => (others => null));

end EingeleseneMusik;
