pragma SPARK_Mode (On);

with SystemDatentypen;

with InteraktionTasks;
with GrafikKonsole;
with GrafikSFML;
with Fehler;

package body StartGrafik is

   procedure StartGrafik
   is begin
      
      GrafikStartenSchleife:
      while InteraktionTasks.ErzeugeFenster = False loop
         
         delay InteraktionTasks.WartezeitGrafik;
         
      end loop GrafikStartenSchleife;
            
      GrafikArtAuswahl;
      
   end StartGrafik;
   
   
   
   procedure GrafikArtAuswahl
   is begin
      
      case
        InteraktionTasks.AktuelleDarstellung
      is
         when SystemDatentypen.Grafik_Konsole =>
            GrafikKonsole.GrafikKonsole;
            
         when SystemDatentypen.Grafik_SFML =>
            GrafikSFML.GrafikSFML;
            
         when others =>
            Fehler.GrafikStopp (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - Ungültige Startdarstellung.");
      end case;
      
   end GrafikArtAuswahl;

end StartGrafik;
