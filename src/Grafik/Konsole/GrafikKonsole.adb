pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with RassenDatentypen; use RassenDatentypen;
with ZeitKonstanten;

with InteraktionLogiktask;
with GrafikIntroKonsole;
with Fehler;
with Karte;
with ForschungAnzeigeKonsole;
with InteraktionGrafiktask;

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
            when GrafikDatentypen.Grafik_Konsole_Enum =>
               InteraktionLogiktask.FensterErzeugtÄndern;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
            
            when GrafikDatentypen.Grafik_SFML_Enum =>
               Fehler.GrafikFehler (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - SFML wird bei Konsole aufgerufen.");
               
            when GrafikDatentypen.Grafik_Sprache_Enum =>
               -- AuswahlSpracheAnzeige.AnzeigeSpracheKonsole;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
               
            when GrafikDatentypen.Grafik_Intro_Enum =>
               GrafikIntroKonsole.Intro;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
                              
            when GrafikDatentypen.Grafik_Pause_Enum =>
               delay ZeitKonstanten.WartezeitGrafik;
               
            when GrafikDatentypen.Grafik_Generierungszeit_Enum =>
               null;
               
            when GrafikDatentypen.Grafik_Laden_Enum =>
               null;
         
            when GrafikDatentypen.Grafik_Menüs_Enum =>
               -- AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
               
            when GrafikDatentypen.Editoren_Anzeigen_Enum'Range =>
               null;
               
            when GrafikDatentypen.Grafik_Weltkarte_Enum =>
               if
                 ---------------------- Leerwert mal auf die leere Konstante umschreiben? Vielleicht generell bei Leerwerten machen?
                 InteraktionLogiktask.AktuelleRasseAbrufen = RassenDatentypen.Keine_Rasse_Enum
               then
                  delay ZeitKonstanten.WartezeitGrafik;
                     
               else
                  Karte.AnzeigeKarte (RasseExtern => InteraktionLogiktask.AktuelleRasseAbrufen);
                  InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
               end if;
               
            when GrafikDatentypen.Grafik_Stadtkarte_Enum =>
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
               
            when GrafikDatentypen.Grafik_Forschung_Enum =>
               ForschungAnzeigeKonsole.ForschungAnzeige;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
               
            when GrafikDatentypen.Grafik_Bauen_Enum =>
               null;
         
            when GrafikDatentypen.Grafik_Ende_Enum =>
               exit GrafikSchleife;
         end case;
               
      end loop GrafikSchleife;
      
   end GrafikKonsole;

end GrafikKonsole;
