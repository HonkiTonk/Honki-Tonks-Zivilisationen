with Sf.Audio;

-- with TonDatentypen;

package EingeleseneMusik is
   pragma Elaborate_Body;

   type Musikarray is array (Positive range <>) of Sf.Audio.sfMusic_Ptr;

   Intromusik : Musikarray (1 .. 1) := (others => null);

   Standardmusik : Musikarray (1 .. 3) := (others => null);

   Forschungserfolg : Musikarray (1 .. 1) := (others => null);

end EingeleseneMusik;
