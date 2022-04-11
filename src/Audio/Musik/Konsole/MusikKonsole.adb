pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen;
with SonstigesKonstanten;

with InteraktionMusiktask;
with Fehler;
with MusikIntroKonsole;

package body MusikKonsole is

   procedure MusikKonsole
   is begin
      
      MusikSchleife:
      loop
         
         case
           InteraktionMusiktask.AktuelleMusik
         is
            when GrafikTonDatentypen.Musik_Konsole_Enum =>
               delay SonstigesKonstanten.WartezeitMusik;
               
            when GrafikTonDatentypen.Musik_Intro_Enum =>
               MusikIntroKonsole.Intro;
               
            when GrafikTonDatentypen.Musik_SFML_Enum =>
               Fehler.MusikFehler (FehlermeldungExtern => "MusikKonsole.MusikKonsole - SFML wird bei Konsole aufgerufen.");
               
            when GrafikTonDatentypen.Musik_Ende_Enum =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
   end MusikKonsole;

end MusikKonsole;
