pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;

with NachMusiktask;
with Fehler;
with MusikIntroTerminal;

package body MusikTerminal is

   procedure MusikTerminal
   is begin
      
      MusikSchleife:
      loop
         
         case
           NachMusiktask.AktuelleMusik
         is
            when TonDatentypen.Musik_Terminal_Enum =>
               delay ZeitKonstanten.WartezeitMusik;
               
            when TonDatentypen.Musik_Intro_Enum =>
               MusikIntroTerminal.Intro;
               
            when TonDatentypen.Musik_SFML_Enum =>
               Fehler.MusikFehler (FehlermeldungExtern => "MusikTerminal.MusikTerminal - SFML bei Terminal aufgerufen.");
               
            when TonDatentypen.Musik_Ende_Enum =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
   end MusikTerminal;

end MusikTerminal;
