pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AuswahlMenues;
with Fehler;

package body OptionenSound is

   function OptionenSound
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SoundSchleife:
      loop
         
         AuswahlWert := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Sound_Menü_Enum);
         
         case
           AuswahlWert
         is  
            when SystemDatentypen.Zurück_Enum | SystemDatentypen.Spiel_Beenden_Enum | SystemDatentypen.Hauptmenü_Enum =>
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSound.OptionenSound - Ungültige Menüauswahl.");
         end case;
         
      end loop SoundSchleife;
      
   end OptionenSound;

end OptionenSound;
