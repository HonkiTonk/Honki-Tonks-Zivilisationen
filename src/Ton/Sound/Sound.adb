with ZeitKonstanten;

with SchreibeLogiktask;
with LeseSoundtask;
with SchreibeSoundtask;
with LeseGesamttask;

with StartEndeSound;
with EinstellungenSound;

package body Sound is

   -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
   procedure Sound
   is begin
      
      EinlesenAbwartenSchleife:
      while LeseGesamttask.EinstellungenEingelesen = False loop
         
         delay ZeitKonstanten.WartezeitSound;
         
      end loop EinlesenAbwartenSchleife;
      
      EinstellungenSound.Lautstärke;
      SchreibeLogiktask.WartenSound (ZustandExtern => False);
            
      SoundSchleife:
      loop
         
         case
           LeseSoundtask.SoundStarten
         is
            when TonDatentypen.Sound_Pause_Enum =>
               delay ZeitKonstanten.WartezeitSound;
                              
            when TonDatentypen.Sound_Ende_Enum =>
               exit SoundSchleife;
               
            when others =>
               WiedergegebeneSounds (LeseSoundtask.SoundStarten) := True;
               StartEndeSound.Abspielen (SoundExtern => LeseSoundtask.SoundStarten);
         end case;
         
         case
           LeseSoundtask.SoundStoppen
         is
            when TonDatentypen.Sound_Pause_Enum =>
               if
                 WiedergegebeneSounds (LeseSoundtask.SoundStarten) = True
               then
                  WiedergegebeneSounds (LeseSoundtask.SoundStarten) := False;
                  SchreibeSoundtask.SoundStarten (SoundExtern => TonDatentypen.Sound_Pause_Enum);
                  
               else
                  null;
               end if;
               
            when TonDatentypen.Sound_Ende_Enum =>
               exit SoundSchleife;
               
            when others =>
               StartEndeSound.Stoppen (SoundExtern => LeseSoundtask.SoundStoppen);
               SchreibeSoundtask.SoundStoppen (SoundExtern => TonDatentypen.Sound_Pause_Enum);
         end case;
         
      end loop SoundSchleife;
      
      StartEndeSound.Entfernen;
      
   end Sound;

end Sound;
