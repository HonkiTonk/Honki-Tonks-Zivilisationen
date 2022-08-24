pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;

with Auswahlaufteilungen;
with Fehler;

package body OptionenSound is

   function OptionenSound
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SoundSchleife:
      loop
         
         AuswahlWert := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Sound_Menü_Enum);
         
         case
           AuswahlWert
         is  
            when RueckgabeDatentypen.Zurück_Enum | RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSound.OptionenSound - Falsche Menüauswahl.");
         end case;
         
      end loop SoundSchleife;
      
   end OptionenSound;

end OptionenSound;
