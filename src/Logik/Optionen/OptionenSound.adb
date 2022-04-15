pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

with AuswahlMenues;
with Fehler;

package body OptionenSound is

   function OptionenSound
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SoundSchleife:
      loop
         
         AuswahlWert := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Sound_Menü_Enum);
         
         case
           AuswahlWert
         is  
            when RueckgabeDatentypen.Zurück_Enum | RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSound.OptionenSound - Ungültige Menüauswahl.");
         end case;
         
      end loop SoundSchleife;
      
   end OptionenSound;

end OptionenSound;
