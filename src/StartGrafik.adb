pragma SPARK_Mode (On);

with SystemDatentypen;

with GrafikWichtigeEinstellungen;
with GrafikKonsole;
with GrafikSFML;
with Fehler;

package body StartGrafik is

   procedure StartGrafik
   is begin
      
      GrafikStartenSchleife:
      while GrafikWichtigeEinstellungen.ErzeugeFenster = False loop
         
         delay GrafikWichtigeEinstellungen.Wartezeit;
         
      end loop GrafikStartenSchleife;
            
      GrafikArtAuswahl;
      
   end StartGrafik;
   
   
   
   procedure GrafikArtAuswahl
   is begin
      
      case
        GrafikWichtigeEinstellungen.AktuelleDarstellung
      is
         when SystemDatentypen.Konsole_Start =>
            GrafikKonsole.GrafikKonsole;
            
         when SystemDatentypen.SFML_Start =>
            GrafikSFML.GrafikSFML;
            
         when others =>
            Fehler.GrafikStopp (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - Ungültige Startdarstellung.");
      end case;
      
   end GrafikArtAuswahl;

end StartGrafik;
