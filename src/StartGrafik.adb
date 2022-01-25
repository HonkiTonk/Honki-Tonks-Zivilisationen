pragma SPARK_Mode (On);

with SystemDatentypen;
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
         when SystemDatentypen.Grafik_Konsole =>
            GrafikKonsole.GrafikKonsole;
            
         when SystemDatentypen.Grafik_SFML =>
            GrafikSFML.GrafikSFML;
            
         when others =>
            Fehler.GrafikStopp (FehlermeldungExtern => "StartGrafik.StartGrafik - Ungültige Startdarstellung.");
      end case;
      
   end StartGrafik;

end StartGrafik;
