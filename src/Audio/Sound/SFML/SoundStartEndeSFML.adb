pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;

with Sf.Audio; use Sf.Audio;
with Sf.Audio.SoundBuffer;

with EingeleseneSounds;

package body SoundStartEndeSFML is

   procedure SoundAbspielen
   is begin
      
      -- Sound wird direkt parallel aufgerufen. Steht auch im SFML Tutorial und der Beschreibung der ASFML.
      if
        EingeleseneSounds.Sound (RassenDatentypen.Keine_Rasse_Enum, 1) = null
      then
         null;
         
      else
         Sf.Audio.Sound.setBuffer (sound  => SoundTest,
                                   buffer => EingeleseneSounds.Sound (RassenDatentypen.Keine_Rasse_Enum, 1));
         Sf.Audio.Sound.play (sound => SoundTest);
      end if;
      
   end SoundAbspielen;
   
   
   
   procedure SoundStoppen
   is begin
      
      -- Anders als bei Musik scheint hier die Prüfung nicht notwendig zu sein?
      if
        EingeleseneSounds.Sound (RassenDatentypen.Keine_Rasse_Enum, 1) = null
      then
         null;
         
      else
         Sf.Audio.Sound.stop (sound => SoundTest);
      end if;
      
   end SoundStoppen;
   
   
   
   procedure SoundEntfernen
   is begin
      
      -- Beide destroys sind nötig sonst gibt es die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms.
      Sf.Audio.SoundBuffer.destroy (soundBuffer => EingeleseneSounds.Sound (RassenDatentypen.Keine_Rasse_Enum, 1));
      Sf.Audio.Sound.destroy (sound => SoundTest);
      
   end SoundEntfernen;

end SoundStartEndeSFML;
