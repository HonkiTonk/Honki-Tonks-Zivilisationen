pragma SPARK_Mode (On);

with SystemDatentypen;
with SystemKonstanten;

with InteraktionTasks;
with GrafikKonsole;
with GrafikSFML;
with Fehler;

package body StartGrafik is

   procedure StartGrafik
   is begin
      
      GrafikStartenSchleife:
      while InteraktionTasks.ErzeugeFensterAbrufen = False loop
         
         delay SystemKonstanten.WartezeitGrafik;
         
      end loop GrafikStartenSchleife;
            
      GrafikArtAuswahl;
      
   end StartGrafik;
   
   
   
   procedure GrafikArtAuswahl
   is begin
      
      case
        InteraktionTasks.AktuelleDarstellungAbrufen
      is
         when SystemDatentypen.Grafik_Konsole =>
            GrafikKonsole.GrafikKonsole;
            
         when SystemDatentypen.Grafik_SFML =>
            GrafikSFML.GrafikSFML;
            
         when others =>
            Fehler.GrafikStopp (FehlermeldungExtern => "StartGrafik.GrafikArtAuswahl - Ungültige Startdarstellung.");
      end case;
      
   end GrafikArtAuswahl;

end StartGrafik;
