pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with RassenDatentypen; use RassenDatentypen;
with ZeitKonstanten;

with InteraktionStart;
with GrafikIntroTerminal;
with Fehler;
with Karte;
with ForschungAnzeigeTerminal;
with InteraktionGrafiktask;

package body GrafikTerminal is

   procedure GrafikTerminal
   is begin
            
      GrafikSchleife:
      loop
         
         -- Hier die Auslagerung der Auswahl auch sinnvoll?
         -- In der Terminalnanzeige später noch die Auswahlinteraktion einbauen.
         case
           InteraktionGrafiktask.AktuelleDarstellung
         is
            when GrafikDatentypen.Grafik_Terminal_Enum =>
               InteraktionStart.FensterErzeugt := True;
               InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            
            when GrafikDatentypen.Grafik_SFML_Enum =>
               Fehler.GrafikFehler (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - SFML wird bei Terminal aufgerufen.");
               
            when GrafikDatentypen.Grafik_Sprache_Enum =>
               -- AuswahlSpracheAnzeige.AnzeigeSpracheTerminal;
               InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               
            when GrafikDatentypen.Grafik_Intro_Enum =>
               GrafikIntroTerminal.Intro;
               InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
                              
            when GrafikDatentypen.Grafik_Pause_Enum =>
               delay ZeitKonstanten.WartezeitGrafik;
               
            when GrafikDatentypen.Grafik_Generierungszeit_Enum =>
               null;
               
            when GrafikDatentypen.Grafik_KI_Rechenzeit_Enum =>
               null;
               
            when GrafikDatentypen.Grafik_Rundenende_Enum =>
               null;
               
            when GrafikDatentypen.Grafik_Speichern_Laden_Enum =>
               null;
         
            when GrafikDatentypen.Grafik_Menüs_Enum =>
               -- AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               
            when GrafikDatentypen.Editoren_Anzeigen_Enum'Range =>
               null;
               
            when GrafikDatentypen.Grafik_Weltkarte_Enum =>
               if
                 ---------------------- Leerwert mal auf die leere Konstante umschreiben? Vielleicht generell bei Leerwerten machen?
                 InteraktionGrafiktask.AktuelleRasseEinheit.Rasse = RassenDatentypen.Keine_Rasse_Enum
               then
                  delay ZeitKonstanten.WartezeitGrafik;
                     
               else
                  Karte.AnzeigeKarte (RasseEinheitExtern => InteraktionGrafiktask.AktuelleRasseEinheit);
                  InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               end if;
               
            when GrafikDatentypen.Grafik_Stadtkarte_Enum =>
               InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               
            when GrafikDatentypen.Grafik_Forschung_Enum =>
               ForschungAnzeigeTerminal.ForschungAnzeige;
               InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               
            when GrafikDatentypen.Grafik_Bauen_Enum =>
               null;
         
            when GrafikDatentypen.Grafik_Ende_Enum =>
               exit GrafikSchleife;
         end case;
               
      end loop GrafikSchleife;
      
   end GrafikTerminal;

end GrafikTerminal;
