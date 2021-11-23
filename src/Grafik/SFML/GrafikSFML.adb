pragma SPARK_Mode (On);

with SystemDatentypen;

with Fehler;
with ImSpiel;
with GrafikStartEnde;
with Intro;
with AuswahlMenueAnzeige;
with Karte;
with GrafikWichtigeEinstellungen;

package body GrafikSFML is
   
   procedure GrafikSFML
   is begin
      
      GrafikStartEnde.FensterErzeugen;

      GrafikSchleife:
      loop
         
         GrafikStartEnde.FensterLeeren;
         
         case
           GrafikWichtigeEinstellungen.AktuelleDarstellung
         is
            when SystemDatentypen.Konsole_Start =>
               -- Aber wie wechselt man dann von der Konsole auf die Grafik? Nur per Neustart?
               Fehler.GrafikStopp (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - Konsole wird bei SFML aufgerufen.");
            
            when SystemDatentypen.SFML_Start =>
               GrafikWichtigeEinstellungen.FensterErzeugt := True;
               GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
               
            when SystemDatentypen.Grafik_Intro =>
               Intro.Intro;
               GrafikWichtigeEinstellungen.AktuelleDarstellung := SystemDatentypen.Grafik_Pause;
                              
            when SystemDatentypen.Grafik_Pause =>
               delay GrafikWichtigeEinstellungen.Wartezeit;
         
            when SystemDatentypen.Grafik_Menüs =>
               AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               
            when SystemDatentypen.Grafik_Eingabe =>
               null;
               
            when SystemDatentypen.Grafik_Weltkarte =>
               case
                 ImSpiel.AktuelleRasse
               is
                  when SystemDatentypen.Keine_Rasse =>
                     delay GrafikWichtigeEinstellungen.Wartezeit;
                     
                  when others =>
                     Karte.AnzeigeKarte (RasseExtern => ImSpiel.AktuelleRasse);
               end case;
               
            when SystemDatentypen.Grafik_Stadtkarte =>
               null;
         
            when SystemDatentypen.Grafik_Ende =>
               exit GrafikSchleife;
         end case;
      
         GrafikStartEnde.FensterAnzeigen;
         
      end loop GrafikSchleife;
      
      GrafikStartEnde.FensterEntfernen;
      
   end GrafikSFML;

end GrafikSFML;
