pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen; use GrafikTonDatentypen;
with SystemDatentypen; use SystemDatentypen;
with SonstigesKonstanten;

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
            when GrafikTonDatentypen.Grafik_Konsole_Enum =>
               InteraktionLogiktask.FensterErzeugtÄndern;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
            
            when GrafikTonDatentypen.Grafik_SFML_Enum =>
               Fehler.GrafikFehler (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - SFML wird bei Konsole aufgerufen.");
               
            when GrafikTonDatentypen.Grafik_Sprache_Enum =>
               -- AuswahlSpracheAnzeige.AnzeigeSpracheKonsole;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
               
            when GrafikTonDatentypen.Grafik_Intro_Enum =>
               GrafikIntroKonsole.Intro;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
                              
            when GrafikTonDatentypen.Grafik_Pause_Enum =>
               delay SonstigesKonstanten.WartezeitGrafik;
               
            when GrafikTonDatentypen.Grafik_Laden_Enum =>
               null;
         
            when GrafikTonDatentypen.Grafik_Menüs_Enum =>
               -- AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
               
            when GrafikTonDatentypen.Editoren_Anzeigen_Enum'Range =>
               null;
               
            when GrafikTonDatentypen.Grafik_Weltkarte_Enum =>
               if
                 ---------------------- Leerwert mal auf die leere Konstante umschreiben? Vielleicht generell bei Leerwerten machen?
                 InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse_Enum
               then
                  delay SonstigesKonstanten.WartezeitGrafik;
                     
               else
                  Karte.AnzeigeKarte (RasseExtern => InteraktionLogiktask.AktuelleRasseAbrufen);
                  InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
               end if;
               
            when GrafikTonDatentypen.Grafik_Stadtkarte_Enum =>
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
               
            when GrafikTonDatentypen.Grafik_Forschung_Enum =>
               ForschungAnzeigeKonsole.ForschungAnzeige;
               InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
               
            when GrafikTonDatentypen.Grafik_Bauen_Enum =>
               null;
         
            when GrafikTonDatentypen.Grafik_Ende_Enum =>
               exit GrafikSchleife;
         end case;
               
      end loop GrafikSchleife;
      
   end GrafikKonsole;

end GrafikKonsole;
