pragma SPARK_Mode (On);

with SystemKonstanten;

with Sf.Audio; use Sf.Audio;
with Sf.Audio.Music;

with EingeleseneMusik;

package body MusikStartEndeSFML is

   procedure MusikAbspielen
   is begin
      
      -- Musik wird direkt parallel aufgerufen. Steht auch im SFML Tutorial, allerdings unter Sound, und der Beschreibung der ASFML.
      if
        EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1) = null
      then
         null;
         
      else
         Sf.Audio.Music.play (music => EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1));
      end if;
      
   end MusikAbspielen;
   
   
   
   procedure MusikStoppen
   is begin
      
      -- Prüfung ist notwendig, da sonst eine Warnmeldung in der Konsole auftaucht dass ein NULL Musik Objekt verwendet wird.
      if
        EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1) = null
      then
         null;
         
      else
         Sf.Audio.Music.stop (music => EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1));
      end if;
      
   end MusikStoppen;
   
   
   
   procedure MusikEntfernen
   is begin
      
      -- destroy ist nötig sonst gibt es die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms.
      Sf.Audio.Music.destroy (music => EingeleseneMusik.Musik (SystemKonstanten.LeerRasse, 1));
      
   end MusikEntfernen;

end MusikStartEndeSFML;
