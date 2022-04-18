pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;
with ZeitKonstanten;
with GrafikDatentypen;
with OptionenVariablen;

with InteraktionLogiktask;
with InteraktionMusiktask;
with MusikSFML;
with MusikKonsole;
with Fehler;

package body StartMusik is

   procedure StartMusik
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      EinlesenAbwartenSchleife:
      while InteraktionLogiktask.EinlesenAbgeschlossen = False loop
         
         delay ZeitKonstanten.WartezeitMusik;
         
      end loop EinlesenAbwartenSchleife;
      
      case
        InteraktionMusiktask.AktuelleMusik
      is
         when TonDatentypen.Musik_SFML_Enum =>
            MusikSFML.MusikSFML;
            
         when TonDatentypen.Musik_Konsole_Enum =>
            MusikKonsole.MusikKonsole;
            
         when others =>
            Fehler.MusikFehler (FehlermeldungExtern => "StartMusik.StartMusik - Ungültige Musikwiedergabeart.");
      end case;
      
   end StartMusik;

end StartMusik;
