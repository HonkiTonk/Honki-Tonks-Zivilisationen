pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with OptionenVariablen;
with GrafikDatentypen;

with AuswahlTerminal;
with AuswahlSFML;

package body Auswahl is
   
   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return RueckgabeDatentypen.Ja_Nein_Enum
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return AuswahlSFML.AuswahlJaNeinSFML (FrageZeileExtern => FrageZeileExtern);
            
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            return AuswahlTerminal.AuswahlJaNeinTerminal (FrageZeileExtern => FrageZeileExtern);
      end case;
      
   end AuswahlJaNein;
   
end Auswahl;
