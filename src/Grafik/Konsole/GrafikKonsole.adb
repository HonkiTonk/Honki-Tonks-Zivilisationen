pragma SPARK_Mode (On);

with SystemDatentypen;
with SystemKonstanten;

with InteraktionLogiktask;
with IntroKonsole;
with Fehler;
with Karte;
with ForschungAnzeigeKonsole;
with InteraktionGrafiktask;
-- with AuswahlSpracheAnzeige;

package body GrafikKonsole is

   procedure GrafikKonsole
   is begin
            
      GrafikSchleife:
      loop
         
         -- Hier die Auslagerung der Auswahl auch sinnvoll?
         -- In der Konsolenanzeige später noch die Auswahlinteraktion einbauen.
         case
           InteraktionGrafiktask.AktuelleDarstellungAbrufen
         is
            when SystemDatentypen.Grafik_Konsole =>
               InteraktionLogiktask.FensterErzeugtÄndern;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
            
            when SystemDatentypen.Grafik_SFML =>
               Fehler.GrafikStopp (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - Konsole wird bei SFML aufgerufen.");
               
            when SystemDatentypen.Grafik_Sprache =>
               -- AuswahlSpracheAnzeige.AnzeigeSpracheKonsole;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               
            when SystemDatentypen.Grafik_Intro =>
               IntroKonsole.Intro;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
                              
            when SystemDatentypen.Grafik_Pause =>
               delay SystemKonstanten.WartezeitGrafik;
               
            when SystemDatentypen.Grafik_Laden =>
               null;
         
            when SystemDatentypen.Grafik_Menüs =>
               -- AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               
            when SystemDatentypen.Editoren_Anzeigen_Enum'Range =>
               null;
               
            when SystemDatentypen.Grafik_Weltkarte =>
               case
                 InteraktionLogiktask.AktuelleRasseAbrufen
               is
                  when SystemDatentypen.Keine_Rasse =>
                     delay SystemKonstanten.WartezeitGrafik;
                     
                  when others =>
                     Karte.AnzeigeKarte (RasseExtern => InteraktionLogiktask.AktuelleRasseAbrufen);
                     InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               end case;
               
            when SystemDatentypen.Grafik_Stadtkarte =>
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               
            when SystemDatentypen.Grafik_Forschung =>
               ForschungAnzeigeKonsole.ForschungAnzeige;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
               
            when SystemDatentypen.Grafik_Bauen =>
               null;
         
            when SystemDatentypen.Grafik_Ende =>
               exit GrafikSchleife;
         end case;
               
      end loop GrafikSchleife;
      
   end GrafikKonsole;

end GrafikKonsole;
