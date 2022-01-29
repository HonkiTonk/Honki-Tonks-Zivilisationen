pragma SPARK_Mode (On);

with Sf.Audio; use Sf.Audio;
with Sf.Audio.Music;

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

with InteraktionMusiktask;
with EingeleseneMusik;

package body Musik is

   procedure Musik
   is begin
         
      -- Musik wird direkt parallel aufgerufen? Oder übersehe ich gerade noch was?
      -- Beim Abspielen von Musik einfach immer eine Sekunde delayen bevor geprüft wird ob die Musik noch spielt?
      if
        EingeleseneMusik.Musik (SystemDatentypen.Keine_Rasse, 1) = null
      then
         null;
         
      else
         Sf.Audio.Music.play (music => EingeleseneMusik.Musik (SystemDatentypen.Keine_Rasse, 1));
      end if;
      
      MusikSchleife:
      loop
         
         case
           InteraktionMusiktask.AktuelleMusik
         is
            when SystemDatentypen.Musik_SFML =>
               delay SystemKonstanten.WartezeitSound;
               
            when SystemDatentypen.Musik_Ende =>
               exit MusikSchleife;
         end case;
      end loop MusikSchleife;
      
      if
        EingeleseneMusik.Musik (SystemDatentypen.Keine_Rasse, 1) = null
      then
         null;
         
      else
         Sf.Audio.Music.stop (music => EingeleseneMusik.Musik (SystemDatentypen.Keine_Rasse, 1));
         -- destroy ist nötig sonst gibt es die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms.
         Sf.Audio.Music.destroy (music => EingeleseneMusik.Musik (SystemDatentypen.Keine_Rasse, 1));
      end if;
      
   end Musik;

end Musik;
