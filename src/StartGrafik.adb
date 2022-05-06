pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with ZeitKonstanten;

with InteraktionGrafiktask;
with GrafikKonsole;
with GrafikSFML;
with Fehler;

package body StartGrafik is

   procedure StartGrafik
   is begin
      
      GrafikStartenSchleife:
      while InteraktionGrafiktask.ErzeugeFensterAbrufen = False loop

         delay ZeitKonstanten.WartezeitGrafik;
         
      end loop GrafikStartenSchleife;
            
      case
        InteraktionGrafiktask.AktuelleDarstellungAbrufen
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            GrafikKonsole.GrafikKonsole;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            GrafikSFML.GrafikSFML;
            
         when others =>
            Fehler.GrafikFehler (FehlermeldungExtern => "StartGrafik.StartGrafik - Ungültige Startdarstellung.");
      end case;
      
   end StartGrafik;

end StartGrafik;
