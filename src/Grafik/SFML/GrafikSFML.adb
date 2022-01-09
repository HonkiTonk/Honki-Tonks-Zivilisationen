pragma SPARK_Mode (On);

-- with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with StadtKonstanten;
with SystemKonstanten;

with Fehler;
with GrafikStartEnde;
with IntroSFML;
with AuswahlMenueAnzeige;
with Karte;
with InteraktionGrafiktask;
with KarteStadt;
with InDerStadt;
with GrafikAllgemein;
with Sichtweiten;
with ForschungAnzeigeSFML;
with AuswahlSpracheAnzeige;
with AnzeigeEingabe;
with BauAuswahlAnzeigeSFML;
with InteraktionLogiktask;

package body GrafikSFML is
   
   procedure GrafikSFML
   is begin
      
      GrafikStartEnde.FensterErzeugen;

      GrafikSchleife:
      loop
         
         case
           InteraktionGrafiktask.FensterVerändertAbrufen
         is
            when True =>
               GrafikAllgemein.FensterAnpassen;
               Sichtweiten.SichtweiteBewegungsfeldFestlegen;
               InteraktionGrafiktask.FensterVerändertÄndern;
               
            when False =>
               null;
         end case;
         
         GrafikStartEnde.FensterLeeren;
         
         case
           AnzeigeAuswahl
         is
            when True =>
               GrafikStartEnde.FensterAnzeigen;
               
            when False =>
               exit GrafikSchleife;
         end case;
         
      end loop GrafikSchleife;
      
      GrafikStartEnde.FensterEntfernen;
      
   end GrafikSFML;
   
   
   
   function AnzeigeAuswahl
     return Boolean
   is begin
      
      case
        InteraktionGrafiktask.AktuelleDarstellungAbrufen
      is
         when SystemDatentypen.Grafik_Konsole =>
            Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.GrafikSFML - Konsole wird bei SFML aufgerufen.");
            
         when SystemDatentypen.Grafik_SFML =>
            InteraktionLogiktask.FensterErzeugtÄndern;
            InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
            
         when SystemDatentypen.Grafik_Sprache =>
            AuswahlSpracheAnzeige.AnzeigeSpracheSFML;
               
         when SystemDatentypen.Grafik_Intro =>
            IntroSFML.Intro;
            InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
                              
         when SystemDatentypen.Grafik_Pause =>
            delay SystemKonstanten.WartezeitGrafik;
               
         when SystemDatentypen.Grafik_Laden =>
            null;
         
         when SystemDatentypen.Grafik_Menüs =>
            AuswahlMenueAnzeige.AnzeigeSFMLAnfang;
               
         when SystemDatentypen.Grafik_Weltkarte =>
            if
              InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse
            then
               delay SystemKonstanten.WartezeitGrafik;
                     
            else
               Karte.AnzeigeKarte (RasseExtern => InteraktionLogiktask.AktuelleRasseAbrufen);
            end if;
               
         when SystemDatentypen.Grafik_Stadtkarte =>
            if
              InDerStadt.AktuelleRasseStadt.Platznummer = StadtKonstanten.LeerNummer
            then
               delay SystemKonstanten.WartezeitGrafik;
                  
            else
               KarteStadt.AnzeigeStadt (StadtRasseNummerExtern => InDerStadt.AktuelleRasseStadt);
            end if;
               
         when SystemDatentypen.Grafik_Forschung =>
            if
              InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.GrafikSFML - Forschungsmenü wird ohne Rasse aufgerufen.");
                     
            else
               ForschungAnzeigeSFML.ForschungAnzeige;
            end if;
            
         when SystemDatentypen.Grafik_Bauen =>
            if
              InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikStopp (FehlermeldungExtern => "GrafikSFML.GrafikSFML - Baumenü wird ohne Rasse aufgerufen.");
                     
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
            AnzeigeEingabe.AnzeigeText;
            
         when SystemDatentypen.Zahlen_Eingabe =>
            AnzeigeEingabe.AnzeigeGanzeZahl;
            
         when SystemDatentypen.Einheit_Auswahl =>
            if
              InteraktionLogiktask.AktuelleRasseAbrufen = SystemDatentypen.Keine_Rasse
            then
               null;
                     
            else
               AnzeigeEingabe.AnzeigeEinheitenStadt (RasseExtern => InteraktionLogiktask.AktuelleRasseAbrufen);
            end if;
               
         when SystemDatentypen.Keine_Eingabe =>
            null;
      end case;
      
   end AnzeigeEingaben;

end GrafikSFML;
