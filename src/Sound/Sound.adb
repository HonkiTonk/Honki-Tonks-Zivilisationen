with ZeitKonstanten;

with NachSoundtask;
with StartEndeSound;
with LogiktaskAnAlle;
with StarteinstellungenSound;
with NachLogiktask;

package body Sound is

   -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
   procedure Sound
   is begin
      
      EinlesenAbwartenSchleife:
      while LogiktaskAnAlle.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitSound;
         
      end loop EinlesenAbwartenSchleife;
      
      StarteinstellungenSound.Lautstärke;
      NachLogiktask.SoundWarten := False;
            
      SoundSchleife:
      loop
         
         case
           NachSoundtask.SoundAbspielen
         is
            when TonDatentypen.Sound_Pause_Enum =>
               delay ZeitKonstanten.WartezeitSound;
                              
            when TonDatentypen.Sound_Ende_Enum =>
               -- Hier vielleicht null und unten drunter dann alle Sounds stoppen und entsprechend die Schleife verlassen? äöü
               exit SoundSchleife;
               
            when others =>
               WiedergegebeneSounds (NachSoundtask.SoundAbspielen) := True;
               StartEndeSound.Abspielen (SoundExtern => NachSoundtask.SoundAbspielen);
         end case;
         
         case
           NachSoundtask.SoundStoppen
         is
            when TonDatentypen.Sound_Pause_Enum =>
               if
                 WiedergegebeneSounds (NachSoundtask.SoundAbspielen) = True
               then
                  WiedergegebeneSounds (NachSoundtask.SoundAbspielen) := False;
                  NachSoundtask.SoundAbspielen := TonDatentypen.Sound_Pause_Enum;
                  
               else
                  null;
               end if;
               
            when TonDatentypen.Sound_Ende_Enum =>
               exit SoundSchleife;
               
            when others =>
               StartEndeSound.Stoppen (SoundExtern => NachSoundtask.SoundStoppen);
               NachSoundtask.SoundStoppen := TonDatentypen.Sound_Pause_Enum;
         end case;
         
      end loop SoundSchleife;
      
      StartEndeSound.Entfernen;
      
   end Sound;

end Sound;
