pragma SPARK_Mode (On);

with Sf.Audio.Music;

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

with InteraktionMusiktask;
with EingeleseneMusik;

package body Musik is

   procedure Musik
   is begin
         
      -- Musik wird direkt parallel aufgerufen? Oder übersehe ich gerade noch was?
      -- Beim Abspielen von Musik einfach immer eine Sekunde delayen bevor gepürft wird ob die Musik noch spielt?
      Sf.Audio.Music.play (music => EingeleseneMusik.MusikTest);
      
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
      
      Sf.Audio.Music.stop (music => EingeleseneMusik.MusikTest);
      
      -- destroy ist nötig sonst gibt es die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" beim Beenden des Programms.
      Sf.Audio.Music.destroy (music => EingeleseneMusik.MusikTest);
      
   end Musik;

end Musik;
