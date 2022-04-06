pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen;
with SystemKonstanten;
with GlobaleVariablen;

with InteraktionLogiktask;
with InteraktionMusiktask;
with MusikSFML;
with MusikKonsole;
with Fehler;

package body StartMusik is

   procedure StartMusik
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      EinlesenAbwartenSchleife:
      while InteraktionLogiktask.EinlesenAbgeschlossen = False loop
         
         delay SystemKonstanten.WartezeitMusik;
         
      end loop EinlesenAbwartenSchleife;
      
      case
        InteraktionMusiktask.AktuelleMusik
      is
         when GrafikTonDatentypen.Musik_SFML_Enum =>
            MusikSFML.MusikSFML;
            
         when GrafikTonDatentypen.Musik_Konsole_Enum =>
            MusikKonsole.MusikKonsole;
            
         when others =>
            Fehler.MusikFehler (FehlermeldungExtern => "StartMusik.StartMusik - Ungültige Musikwiedergabeart.");
      end case;
      
   end StartMusik;

end StartMusik;
