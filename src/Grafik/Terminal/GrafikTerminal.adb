pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with ZeitKonstanten;

with NachLogiktask;
with GrafikIntroTerminal;
with Fehler;
with Karte;
with ForschungAnzeigeTerminal;
with NachGrafiktask;

package body GrafikTerminal is

   procedure GrafikTerminal
   is begin
            
      GrafikSchleife:
      loop
         
         -- Hier die Auslagerung der Auswahl auch sinnvoll?
         -- In der Terminalnanzeige später noch die Auswahlinteraktion einbauen.
         case
           NachGrafiktask.AktuelleDarstellung
         is
            when GrafikDatentypen.Grafik_Terminal_Enum =>
               NachLogiktask.Warten := False;
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            
            when GrafikDatentypen.Grafik_SFML_Enum =>
               Fehler.GrafikFehler (FehlermeldungExtern => "SFMLDarstellungAuswahl.SFMLDarstellungAuswahl - SFML wird bei Terminal aufgerufen.");
               
            when GrafikDatentypen.Grafik_Sprache_Enum =>
               -- AuswahlSpracheAnzeige.AnzeigeSpracheTerminal;
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               
            when GrafikDatentypen.Grafik_Intro_Enum =>
               GrafikIntroTerminal.Intro;
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
                              
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
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               
            when GrafikDatentypen.Editoren_Anzeigen_Enum'Range =>
               null;
               
            when GrafikDatentypen.Grafik_Weltkarte_Enum =>
                  Karte.AnzeigeKarte (RasseEinheitExtern => (NachGrafiktask.AktuelleRasse, NachGrafiktask.AktuelleEinheit));
               
            when GrafikDatentypen.Grafik_Stadtkarte_Enum =>
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               
            when GrafikDatentypen.Grafik_Forschung_Enum =>
               ForschungAnzeigeTerminal.ForschungAnzeige;
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               
            when GrafikDatentypen.Grafik_Bauen_Enum =>
               null;
         
            when GrafikDatentypen.Grafik_Ende_Enum =>
               exit GrafikSchleife;
         end case;
               
      end loop GrafikSchleife;
      
   end GrafikTerminal;

end GrafikTerminal;
