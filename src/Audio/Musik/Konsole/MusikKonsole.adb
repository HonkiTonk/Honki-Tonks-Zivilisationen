pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;

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
            when TonDatentypen.Musik_Konsole_Enum =>
               delay ZeitKonstanten.WartezeitMusik;
               
            when TonDatentypen.Musik_Intro_Enum =>
               MusikIntroKonsole.Intro;
               
            when TonDatentypen.Musik_SFML_Enum =>
               Fehler.MusikFehler (FehlermeldungExtern => "MusikKonsole.MusikKonsole - SFML wird bei Konsole aufgerufen.");
               
            when TonDatentypen.Musik_Ende_Enum =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
   end MusikKonsole;

end MusikKonsole;
