with RassenDatentypen;

with Sf.Audio; use Sf.Audio;
with Sf.Audio.Music;

with EingeleseneMusik;

package body StartEndeMusik is

   procedure Abspielen
   is begin
      
      -- Musik wird direkt parallel aufgerufen. Steht auch im SFML Tutorial, allerdings unter Sound, und der Beschreibung der ASFML.
      if
        EingeleseneMusik.Musik (RassenDatentypen.Keine_Rasse_Enum, 1) = null
      then
         null;
         
      else
         Sf.Audio.Music.play (music => EingeleseneMusik.Musik (RassenDatentypen.Keine_Rasse_Enum, 1));
      end if;
      
   end Abspielen;
   
   
   
   procedure Stoppen
   is begin
      
      if
        EingeleseneMusik.Musik (RassenDatentypen.Keine_Rasse_Enum, 1) = null
      then
         null;
         
      else
         Sf.Audio.Music.stop (music => EingeleseneMusik.Musik (RassenDatentypen.Keine_Rasse_Enum, 1));
      end if;
      
   end Stoppen;
   
   
   
   procedure Entfernen
   is begin
      
      -- destroy ist nötig sonst gibt es die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms.
      Sf.Audio.Music.destroy (music => EingeleseneMusik.Musik (RassenDatentypen.Keine_Rasse_Enum, 1));
      
   end Entfernen;

end StartEndeMusik;
