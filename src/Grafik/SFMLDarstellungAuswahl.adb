pragma SPARK_Mode (On);

with SystemDatentypen;

with SFMLDarstellungEinstellungen;
with GrafikStartEnde;
with Intro;
with AuswahlMenueAnzeige;
with GrafikAllgemein;
with Karte;
with ImSpiel;
with Fehler;

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
            Fehler.GrafikStopp (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - Ungültige Startdarstellung.");
      end case;
      
      GrafikSchleife:
      loop
         
         GrafikAllgemein.FensterLeeren;
         
         case
           SFMLDarstellungEinstellungen.AktuelleDarstellung
         is
            when SystemDatentypen.Konsole =>
               -- Eine Abfrage einbauen um das Starten des Fenster direkt zu verhindern? Aber wie wechselt man dann von der Konsole auf die Grafik? Nur per Neustart?
               Fehler.GrafikStopp (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - Konsole wird bei SFML aufgerufen.");
            
            when SystemDatentypen.SFML_Start =>
               SFMLDarstellungEinstellungen.FensterErzeugt := True;
               SFMLDarstellungEinstellungen.AktuelleDarstellung := SystemDatentypen.SFML_Pause;
               
            when SystemDatentypen.SFML_Intro =>
               Intro.Intro;
               SFMLDarstellungEinstellungen.AktuelleDarstellung := SystemDatentypen.SFML_Pause;
                              
            when SystemDatentypen.SFML_Pause =>
               delay SFMLDarstellungEinstellungen.Wartezeit;
         
            when SystemDatentypen.SFML_Menüs =>
               AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               
            when SystemDatentypen.SFML_Eingabe =>
               null;
               
            when SystemDatentypen.SFML_Weltkarte =>
               case
                 ImSpiel.AktuelleRasse
               is
                  when SystemDatentypen.Keine_Rasse =>
                     delay SFMLDarstellungEinstellungen.Wartezeit;
                     
                  when others =>
                     Karte.AnzeigeKarte (RasseExtern => ImSpiel.AktuelleRasse);
               end case;
               
            when SystemDatentypen.SFML_Stadtkarte =>
               null;
         
            when SystemDatentypen.SFML_Ende =>
               exit GrafikSchleife;
         end case;
      
         GrafikAllgemein.FensterAnzeigen;
         
      end loop GrafikSchleife;
      
      GrafikStartEnde.FensterEntfernen;
      
   end SFMLDarstellungAuswahl;

end SFMLDarstellungAuswahl;
