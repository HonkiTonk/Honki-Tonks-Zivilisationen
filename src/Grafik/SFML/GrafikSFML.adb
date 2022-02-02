pragma SPARK_Mode (On);

-- with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with StadtKonstanten;
with SystemKonstanten;

with Fehler;
with GrafikStartEndeSFML;
with GrafikIntroSFML;
with AnzeigeAuswahlMenueSFML;
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
-- with GrafikEinstellungenSFML;

package body GrafikSFML is
   
   procedure GrafikSFML
   is begin
      
      GrafikStartEndeSFML.FensterErzeugen;

      GrafikSchleife:
      loop
         
         case
           InteraktionGrafiktask.FensterVerändert
         is
            when InteraktionGrafiktask.Fenster_Verändert_Enum'Range =>
               GrafikAllgemeinSFML.FensterAnpassen;
               Sichtweiten.SichtweiteBewegungsfeldFestlegen;
               InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Keine_Änderung;
               
            when InteraktionGrafiktask.Fenster_Unverändert_Enum'Range =>
               null;
         end case;
         
         case
           InteraktionGrafiktask.FensterVerändert
         is
            when InteraktionGrafiktask.Bildrate_Ändern =>
               GrafikAllgemeinSFML.BildrateÄndern;
               InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Keine_Änderung;
               
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
         when SystemDatentypen.Grafik_Konsole =>
            Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Konsole wird bei SFML aufgerufen.");
            
         when SystemDatentypen.Grafik_SFML =>
            InteraktionLogiktask.FensterErzeugtÄndern;
            InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
            
         when SystemDatentypen.Grafik_Sprache =>
            AnzeigeSprachauswahlSFML.AnzeigeSprache;
               
         when SystemDatentypen.Grafik_Intro =>
            GrafikIntroSFML.Intro;
            InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
                              
         when SystemDatentypen.Grafik_Pause =>
            delay SystemKonstanten.WartezeitGrafik;
            
         when SystemDatentypen.Grafik_Laden =>
            null;
         
         when SystemDatentypen.Grafik_Menüs =>
            AnzeigeAuswahlMenueSFML.AnzeigeAnfang;
               
         when SystemDatentypen.Editoren_Anzeigen_Enum'Range =>
            AnzeigeEditoren;
               
         when SystemDatentypen.Grafik_Weltkarte =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            
            if
              AktuelleRasse = SystemKonstanten.LeerRasse
            then
               delay SystemKonstanten.WartezeitGrafik;
                     
            else
               Karte.AnzeigeKarte (RasseExtern => AktuelleRasse);
            end if;
               
         when SystemDatentypen.Grafik_Stadtkarte =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            AktuelleStadtNummer := InDerStadt.AktuelleStadtNummerGrafik; 
            
            if
              AktuelleRasse = SystemKonstanten.LeerRasse
              or
                AktuelleStadtNummer = StadtKonstanten.LeerNummer
            then
               delay SystemKonstanten.WartezeitGrafik;
                  
            else
               KarteStadt.AnzeigeStadt (StadtRasseNummerExtern => (AktuelleRasse, AktuelleStadtNummer));
            end if;
               
         when SystemDatentypen.Grafik_Forschung =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            
            if
              AktuelleRasse = SystemKonstanten.LeerRasse
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Forschungsmenü wird ohne Rasse aufgerufen.");
                     
            else
               ForschungAnzeigeSFML.ForschungAnzeige;
            end if;
            
         when SystemDatentypen.Grafik_Bauen =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            
            if
              AktuelleRasse = SystemKonstanten.LeerRasse
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Baumenü wird ohne Rasse aufgerufen.");
                     
            else
               BauAuswahlAnzeigeSFML.BauAuswahlAnzeige;
            end if;
         
         when SystemDatentypen.Grafik_Ende =>
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
         when SystemDatentypen.Text_Eingabe =>
            AnzeigeEingabeSFML.AnzeigeText;
            
         when SystemDatentypen.Zahlen_Eingabe =>
            AnzeigeEingabeSFML.AnzeigeGanzeZahl;
            
         when SystemDatentypen.Einheit_Auswahl =>
            AktuelleRasse := InteraktionLogiktask.AktuelleRasseAbrufen;
            
            if
              AktuelleRasse = SystemKonstanten.LeerRasse
            then
               null;
                     
            else
               AnzeigeEingabeSFML.AnzeigeEinheitenStadt (RasseExtern => AktuelleRasse);
            end if;
               
         when SystemDatentypen.Keine_Eingabe =>
            null;
      end case;
      
   end AnzeigeEingaben;
   
   
   
   procedure AnzeigeEditoren
   is begin
      
      null;
      
   end AnzeigeEditoren;

end GrafikSFML;
