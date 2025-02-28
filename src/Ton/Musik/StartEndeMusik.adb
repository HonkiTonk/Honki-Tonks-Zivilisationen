with Sf.Audio.Music;
with Sf.Audio.SoundStatus;

with EingeleseneMusik;

package body StartEndeMusik is

   -- Musik wird direkt parallel aufgerufen. Steht auch im SFML Tutorial, allerdings unter Sound, und in der Beschreibung der ASFML.
   procedure Abspielen
     (MusikExtern : in Sf.Audio.sfMusic_Ptr)
   is
      use type Sf.Audio.sfMusic_Ptr;
   begin
      
      if
        MusikExtern = null
      then
         null;
         
      else
         Sf.Audio.Music.play (music => MusikExtern);
      end if;
      
   end Abspielen;
   
   
   
   procedure Stoppen
     (MusikExtern : in Sf.Audio.sfMusic_Ptr)
   is
      use type Sf.Audio.sfMusic_Ptr;
   begin
      
      if
        MusikExtern = null
      then
         null;
         
      else
         Sf.Audio.Music.stop (music => MusikExtern);
      end if;
         
   end Stoppen;
   
   
   
   procedure Entfernen
   is begin
      
      IntroSchleife:
      for IntroSchleifenwert in EingeleseneMusik.Intromusik'Range loop
         
         EntfernenVorgang (MusikExtern => EingeleseneMusik.Intromusik (IntroSchleifenwert));
         
      end loop IntroSchleife;
      
      
      
      SpielSchleife:
      for SpielSchleifenwert in EingeleseneMusik.Spielmusik'Range loop
         
         EntfernenVorgang (MusikExtern => EingeleseneMusik.Spielmusik (SpielSchleifenwert));
         
      end loop SpielSchleife;
      
      
      
      ForschungSchleife:
      for ForschungSchleifenwert in EingeleseneMusik.Forschungsmusik'Range loop
         
         EntfernenVorgang (MusikExtern => EingeleseneMusik.Forschungsmusik (ForschungSchleifenwert));
         
      end loop ForschungSchleife;
      
   end Entfernen;
   
   
   
   procedure EntfernenVorgang
     (MusikExtern : in Sf.Audio.sfMusic_Ptr)
   is
      use type Sf.Audio.sfMusic_Ptr;
      use type Sf.Audio.SoundStatus.sfSoundStatus;
   begin
      
      if
        MusikExtern = null
      then
         null;
               
      else
         case
           Sf.Audio.Music.getStatus (music => MusikExtern)
         is
            when Sf.Audio.SoundStatus.sfPlaying =>
               Sf.Audio.Music.stop (music => MusikExtern);
         
            when others =>
               null;
         end case;
               
         Sf.Audio.Music.destroy (music => MusikExtern);
      end if;
      
   end EntfernenVorgang;
     
end StartEndeMusik;
