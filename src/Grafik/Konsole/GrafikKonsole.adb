pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;

with InteraktionLogiktask;
with GrafikIntroKonsole;
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
            when SystemDatentypen.Grafik_Konsole_Enum =>
               InteraktionLogiktask.FensterErzeugtÄndern;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause_Enum);
            
            when SystemDatentypen.Grafik_SFML_Enum =>
               Fehler.GrafikFehler (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - SFML wird bei Konsole aufgerufen.");
               
            when SystemDatentypen.Grafik_Sprache_Enum =>
               -- AuswahlSpracheAnzeige.AnzeigeSpracheKonsole;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause_Enum);
               
            when SystemDatentypen.Grafik_Intro_Enum =>
               GrafikIntroKonsole.Intro;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause_Enum);
                              
            when SystemDatentypen.Grafik_Pause_Enum =>
               delay SystemKonstanten.WartezeitGrafik;
               
            when SystemDatentypen.Grafik_Laden_Enum =>
               null;
         
            when SystemDatentypen.Grafik_Menüs_Enum =>
               -- AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause_Enum);
               
            when SystemDatentypen.Editoren_Anzeigen_Enum'Range =>
               null;
               
            when SystemDatentypen.Grafik_Weltkarte_Enum =>
               if
                 InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse_Enum
               then
                  delay SystemKonstanten.WartezeitGrafik;
                     
               else
                  Karte.AnzeigeKarte (RasseExtern => InteraktionLogiktask.AktuelleRasseAbrufen);
                  InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause_Enum);
               end if;
               
            when SystemDatentypen.Grafik_Stadtkarte_Enum =>
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause_Enum);
               
            when SystemDatentypen.Grafik_Forschung_Enum =>
               ForschungAnzeigeKonsole.ForschungAnzeige;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause_Enum);
               
            when SystemDatentypen.Grafik_Bauen_Enum =>
               null;
         
            when SystemDatentypen.Grafik_Ende_Enum =>
               exit GrafikSchleife;
         end case;
               
      end loop GrafikSchleife;
      
   end GrafikKonsole;

end GrafikKonsole;
