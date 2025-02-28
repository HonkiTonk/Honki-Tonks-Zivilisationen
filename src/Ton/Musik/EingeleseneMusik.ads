with Sf.Audio;

-- with TonDatentypen;

package EingeleseneMusik is
   pragma Elaborate_Body;

   type Musikarray is array (Positive range <>) of Sf.Audio.sfMusic_Ptr;

   Intromusik : Musikarray (1 .. 1) := (others => null);

   Spielmusik : Musikarray (1 .. 5) := (others => null);

   Forschungsmusik : Musikarray (1 .. 1) := (others => null);

end EingeleseneMusik;
