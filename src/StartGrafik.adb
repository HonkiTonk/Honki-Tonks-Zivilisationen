pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen;
with SystemKonstanten;

with InteraktionGrafiktask;
with GrafikKonsole;
with GrafikSFML;
with Fehler;

package body StartGrafik is

   procedure StartGrafik
   is begin

      GrafikStartenSchleife:
      while InteraktionGrafiktask.ErzeugeFensterAbrufen = False loop

         delay SystemKonstanten.WartezeitGrafik;
         
      end loop GrafikStartenSchleife;
            
      case
        InteraktionGrafiktask.AktuelleDarstellungAbrufen
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            GrafikKonsole.GrafikKonsole;
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            GrafikSFML.GrafikSFML;
            
         when others =>
            Fehler.GrafikFehler (FehlermeldungExtern => "StartGrafik.StartGrafik - Ungültige Startdarstellung.");
      end case;
      
   end StartGrafik;

end StartGrafik;
