pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
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
         when SystemDatentypen.Grafik_Konsole_Enum =>
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
         when SystemDatentypen.Musik_SFML_Enum =>
            MusikSFML.MusikSFML;
            
         when SystemDatentypen.Musik_Konsole_Enum =>
            MusikKonsole.MusikKonsole;
            
         when others =>
            Fehler.MusikFehler (FehlermeldungExtern => "StartMusik.StartMusik - Ungültige Musikwiedergabeart.");
      end case;
      
   end StartMusik;

end StartMusik;
