pragma SPARK_Mode (On);

with SystemDatentypen;

with SFMLDarstellungEinstellungen;
with GrafikStartEnde;
with Intro;

package body SFMLDarstellungAuswahl is

   procedure SFMLDarstellungAuswahl
   is begin
      
      case
        SFMLDarstellungEinstellungen.AktuelleDarstellung
      is
         when SystemDatentypen.Konsole =>
            SFMLDarstellungEinstellungen.FensterErzeugt := True;
            return;
            
         when SystemDatentypen.SFML_Start =>
            GrafikStartEnde.FensterErzeugen;
            
         when others =>
            SFMLDarstellungEinstellungen.KritischesProblem := True;
            raise Program_Error;
      end case;
      
      GrafikSchleife:
      loop
         
         case
           SFMLDarstellungEinstellungen.AktuelleDarstellung
         is
            when SystemDatentypen.Konsole =>
               -- Eine Abfrage einbauen um das Starten des Fenster direkt zu verhindern? Aber wie wechselt man dann von der Konsole auf die Grafik? Nur per Neustart?
               raise Program_Error;
            
            when SystemDatentypen.SFML_Start =>
               SFMLDarstellungEinstellungen.FensterErzeugt := True;
               SFMLDarstellungEinstellungen.AktuelleDarstellung := SystemDatentypen.SFML_Pause;
               
            when SystemDatentypen.SFML_Intro =>
               Intro.Intro;
               SFMLDarstellungEinstellungen.AktuelleDarstellung := SystemDatentypen.SFML_Pause;
                              
            when SystemDatentypen.SFML_Pause =>
               delay SFMLDarstellungEinstellungen.Wartezeit;
         
            when SystemDatentypen.SFML_Menüs =>
               null;
               
            when SystemDatentypen.SFML_Weltkarte =>
               null;
               
            when SystemDatentypen.SFML_Stadtkarte =>
               null;
         
            when SystemDatentypen.SFML_Ende =>
               exit GrafikSchleife;
         end case;
         
      end loop GrafikSchleife;
      
      GrafikStartEnde.FensterEntfernen;
      
   end SFMLDarstellungAuswahl;

end SFMLDarstellungAuswahl;
