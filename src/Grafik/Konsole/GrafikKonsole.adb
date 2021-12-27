pragma SPARK_Mode (On);

with SystemDatentypen;

with InteraktionTasks;
with Intro;
with Fehler;
with Karte;
with ForschungAnzeigeKonsole;
-- with AuswahlSpracheAnzeige;

package body GrafikKonsole is

   procedure GrafikKonsole
   is begin
            
      GrafikSchleife:
      loop
         
         -- Hier die Auslagerung der Auswahl auch sinnvoll?
         -- In der Konsolenanzeige später noch die Auswahlinteraktion einbauen.
         case
           InteraktionTasks.AktuelleDarstellungAbrufen
         is
            when SystemDatentypen.Grafik_Konsole =>
               InteraktionTasks.FensterErzeugtÄndern;
               InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
            
            when SystemDatentypen.Grafik_SFML =>
               Fehler.GrafikStopp (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - Konsole wird bei SFML aufgerufen.");
               
            when SystemDatentypen.Grafik_Sprache =>
               -- AuswahlSpracheAnzeige.AnzeigeSpracheKonsole;
               InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               
            when SystemDatentypen.Grafik_Intro =>
               Intro.Intro;
               InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
                              
            when SystemDatentypen.Grafik_Pause =>
               delay InteraktionTasks.WartezeitGrafik;
         
            when SystemDatentypen.Grafik_Menüs =>
               -- AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               
            when SystemDatentypen.Grafik_Weltkarte =>
               case
                 InteraktionTasks.AktuelleRasseAbrufen
               is
                  when SystemDatentypen.Keine_Rasse =>
                     delay InteraktionTasks.WartezeitGrafik;
                     
                  when others =>
                     Karte.AnzeigeKarte (RasseExtern => InteraktionTasks.AktuelleRasseAbrufen);
                     InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               end case;
               
            when SystemDatentypen.Grafik_Stadtkarte =>
               InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               
            when SystemDatentypen.Grafik_Forschung =>
               ForschungAnzeigeKonsole.ForschungAnzeige;
               InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               
            when SystemDatentypen.Grafik_Bauen =>
               null;
         
            when SystemDatentypen.Grafik_Ende =>
               exit GrafikSchleife;
         end case;
               
      end loop GrafikSchleife;
      
   end GrafikKonsole;

end GrafikKonsole;
