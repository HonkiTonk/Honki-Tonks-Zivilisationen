pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GrafikTonDatentypen;
with StadtKonstanten;
with SystemKonstanten;

with Fehler;
with GrafikStartEndeSFML;
with GrafikIntroSFML;
with AuswahlMenuesSFML;
with Karte;
with InteraktionGrafiktask;
with KarteStadt;
with InDerStadt;
with GrafikAllgemeinSFML;
with Sichtweiten;
with ForschungAnzeigeSFML;
with AnzeigeSprachauswahlSFML;
with AnzeigeEingabeSFML;
with BauAuswahlAnzeigeSFML;
with InteraktionLogiktask;
with EingabeSystemeSFML;

package body GrafikSFML is
   
   procedure GrafikSFML
   is begin
      
      GrafikStartEndeSFML.FensterErzeugen;

      GrafikSchleife:
      loop
         
         case
           InteraktionGrafiktask.FensterVerändert
         is
            when InteraktionGrafiktask.Fenster_Wurde_Verändert_Enum'Range =>
               GrafikAllgemeinSFML.FensterAnpassen;
               Sichtweiten.SichtweiteBewegungsfeldFestlegen;
               InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Keine_Änderung_Enum;
               
            when InteraktionGrafiktask.Fenster_Unverändert_Enum'Range =>
               null;
         end case;
         
         case
           InteraktionGrafiktask.FensterVerändert
         is
            when InteraktionGrafiktask.Bildrate_Ändern_Enum =>
               GrafikAllgemeinSFML.BildrateÄndern;
               InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Keine_Änderung_Enum;
               
            when others =>
               null;
         end case;
         
         GrafikStartEndeSFML.FensterLeeren;
         
         case
           InteraktionGrafiktask.TastenEingabe
         is
            when True =>
               EingabeSystemeSFML.TastenEingabe;
               InteraktionGrafiktask.TastenEingabe := False;
               
            when False =>
               null;
         end case;
         
         case
           InteraktionGrafiktask.FensterGeschlossen
         is
            when True =>
               exit GrafikSchleife;
               
            when False =>
               null;
         end case;
         
         case
           InteraktionGrafiktask.TextEingabe
         is
            when True =>
               EingabeSystemeSFML.TextEingeben;
               
            when False =>
               null;
         end case;
         
         case
           AnzeigeAuswahl
         is
            when True =>
               GrafikStartEndeSFML.FensterAnzeigen;
               
            when False =>
               exit GrafikSchleife;
         end case;
         
      end loop GrafikSchleife;
      
      GrafikStartEndeSFML.FensterEntfernen;
      
   end GrafikSFML;
   
   
   
   function AnzeigeAuswahl
     return Boolean
   is begin
            
      case
        InteraktionGrafiktask.AktuelleDarstellungAbrufen
      is
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Konsole wird bei SFML aufgerufen.");
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            InteraktionLogiktask.FensterErzeugtÄndern;
            InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
            
         when GrafikTonDatentypen.Grafik_Sprache_Enum =>
            AnzeigeSprachauswahlSFML.AnzeigeSprache;
               
         when GrafikTonDatentypen.Grafik_Intro_Enum =>
            GrafikIntroSFML.Intro;
            InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
                              
         when GrafikTonDatentypen.Grafik_Pause_Enum =>
            delay SystemKonstanten.WartezeitGrafik;
            
         when GrafikTonDatentypen.Grafik_Laden_Enum =>
            null;
         
         when GrafikTonDatentypen.Grafik_Menüs_Enum =>
            AktuellesMenü := InteraktionGrafiktask.AktuellesMenü;
            
            if
              AktuellesMenü = SystemDatentypen.Leer_Menü_Enum
            then
               null;
               
            else
               AuswahlMenuesSFML.AuswahlMenüsAufteilung (WelchesMenüExtern => AktuellesMenü);
            end if;
            -- AnzeigeAuswahlMenueSFML.AnzeigeAnfang;
               
         when GrafikTonDatentypen.Editoren_Anzeigen_Enum'Range =>
            AnzeigeEditoren;
               
         when GrafikTonDatentypen.Grafik_Weltkarte_Enum =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            
            if
              AktuelleRasse = SystemDatentypen.Keine_Rasse_Enum
            then
               delay SystemKonstanten.WartezeitGrafik;
                     
            else
               Karte.AnzeigeKarte (RasseExtern => AktuelleRasse);
            end if;
               
         when GrafikTonDatentypen.Grafik_Stadtkarte_Enum =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            AktuelleStadtNummer := InDerStadt.AktuelleStadtNummerGrafik; 
            
            if
              AktuelleRasse = SystemDatentypen.Keine_Rasse_Enum
              or
                AktuelleStadtNummer = StadtKonstanten.LeerNummer
            then
               delay SystemKonstanten.WartezeitGrafik;
                  
            else
               KarteStadt.AnzeigeStadt (StadtRasseNummerExtern => (AktuelleRasse, AktuelleStadtNummer));
            end if;
               
         when GrafikTonDatentypen.Grafik_Forschung_Enum =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            
            if
              AktuelleRasse = SystemDatentypen.Keine_Rasse_Enum
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikFehler (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Forschungsmenü wird ohne Rasse aufgerufen.");
                     
            else
               ForschungAnzeigeSFML.ForschungAnzeige;
            end if;
            
         when GrafikTonDatentypen.Grafik_Bauen_Enum =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            
            if
              AktuelleRasse = SystemDatentypen.Keine_Rasse_Enum
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikFehler (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Baumenü wird ohne Rasse aufgerufen.");
                     
            else
               BauAuswahlAnzeigeSFML.BauAuswahlAnzeige;
            end if;
         
         when GrafikTonDatentypen.Grafik_Ende_Enum =>
            return False;
      end case;
      
      AnzeigeEingaben;
      
      return True;
      
   end AnzeigeAuswahl;
   
   
   
   procedure AnzeigeEingaben
   is begin
      
      case
        InteraktionGrafiktask.EingabeAbrufen
      is
         when SystemDatentypen.Text_Eingabe_Enum =>
            AnzeigeEingabeSFML.AnzeigeText;
            
         when SystemDatentypen.Zahlen_Eingabe_Enum =>
            AnzeigeEingabeSFML.AnzeigeGanzeZahl;
            
         when SystemDatentypen.Einheit_Auswahl_Enum =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            
            if
              AktuelleRasse = SystemDatentypen.Keine_Rasse_Enum
            then
               null;
                     
            else
               AnzeigeEingabeSFML.AnzeigeEinheitenStadt (RasseExtern => AktuelleRasse);
            end if;
               
         when SystemDatentypen.Keine_Eingabe_Enum =>
            null;
      end case;
      
   end AnzeigeEingaben;
   
   
   
   procedure AnzeigeEditoren
   is begin
      
      null;
      
   end AnzeigeEditoren;

end GrafikSFML;
