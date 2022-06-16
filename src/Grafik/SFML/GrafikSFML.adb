pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with RassenDatentypen; use RassenDatentypen;
with MenueDatentypen; use MenueDatentypen;
with StadtDatentypen; use StadtDatentypen;
with GrafikDatentypen;
with StadtKonstanten;
with ZeitKonstanten;

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
with InteraktionStart;
with EingabeSystemeSFML;
with TextaccesseAllesSetzenSFML;
with InteraktionTextanzeige;
with InteraktionEingabe;
with LadezeitenSFML;

package body GrafikSFML is
   
   procedure GrafikSFML
   is begin
      
      -- Das Setzen der Schriftart kann scheinbar erst nach dem Erzeugen eines Fensters stattfinden.
      GrafikStartEndeSFML.FensterErzeugen;
            
      GrafikSchleife:
      loop
         
         GrafikanpassungenVorFensterleerung;
         
         GrafikStartEndeSFML.FensterLeeren;
         
         Eingaben;
         
         case
           InteraktionGrafiktask.FensterGeschlossen
         is
            when True =>
               exit GrafikSchleife;
               
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
   
   
   
   procedure GrafikanpassungenVorFensterleerung
   is begin
      
      case
        InteraktionTextanzeige.AccesseSetzen
      is
         when True =>
            TextaccesseAllesSetzenSFML.AllesAufStandard;
            InteraktionTextanzeige.AccesseSetzen := False;
               
         when False =>
            null;
      end case;
         
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
      
   end GrafikanpassungenVorFensterleerung;
   
   
   
   procedure Eingaben
   is begin
      
      case
        InteraktionEingabe.TextEingabe
      is
         when True =>
            EingabeSystemeSFML.TextEingeben;
               
         when False =>
            null;
      end case;
         
      case
        InteraktionEingabe.TastenEingabe
      is
         when True =>
            EingabeSystemeSFML.TastenEingabe;
            InteraktionEingabe.TastenEingabe := False;
               
         when False =>
            null;
      end case;
      
   end Eingaben;
   
   
   
   function AnzeigeAuswahl
     return Boolean
   is begin
            
      case
        InteraktionGrafiktask.AktuelleDarstellung
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Terminal wird bei SFML aufgerufen.");
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            InteraktionStart.FensterErzeugt := True;
            InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            
         when GrafikDatentypen.Grafik_Sprache_Enum =>
            AnzeigeSprachauswahlSFML.AnzeigeSprache;
               
         when GrafikDatentypen.Grafik_Intro_Enum =>
            GrafikIntroSFML.Intro;
            InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
                              
         when GrafikDatentypen.Grafik_Pause_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            
         when GrafikDatentypen.Grafik_Generierungszeit_Enum =>
            LadezeitenSFML.SpielweltErstellen;
            
         when GrafikDatentypen.Grafik_KI_Rechenzeit_Enum =>
            LadezeitenSFML.KIRechnet;
            
         when GrafikDatentypen.Grafik_Rundenende_Enum =>
            LadezeitenSFML.Rundenende;
            
         when GrafikDatentypen.Grafik_Speichern_Laden_Enum =>
            LadezeitenSFML.SpeichernLaden;
         
         when GrafikDatentypen.Grafik_Menüs_Enum =>
            AktuellesMenü := InteraktionGrafiktask.AktuellesMenü;
            
            if
              AktuellesMenü = MenueDatentypen.Leer_Menü_Enum
            then
               null;
               
            else
               AuswahlMenuesSFML.AuswahlMenüsAufteilung (WelchesMenüExtern => AktuellesMenü);
            end if;
               
         when GrafikDatentypen.Editoren_Anzeigen_Enum'Range =>
            AnzeigeEditoren;
               
         when GrafikDatentypen.Grafik_Weltkarte_Enum =>
            AktuelleRasseEinheit := InteraktionGrafiktask.AktuelleRasseEinheit;
            
            if
              AktuelleRasseEinheit.Rasse = RassenDatentypen.Keine_Rasse_Enum
            then
               delay ZeitKonstanten.WartezeitGrafik;
                     
            else
               Karte.AnzeigeKarte (RasseEinheitExtern => AktuelleRasseEinheit);
            end if;
               
         when GrafikDatentypen.Grafik_Stadtkarte_Enum =>
            AktuelleRasseStadt := (InteraktionGrafiktask.AktuelleRasseEinheit.Rasse, InDerStadt.AktuelleStadtNummerGrafik);
            
            if
              AktuelleRasseStadt.Rasse = RassenDatentypen.Keine_Rasse_Enum
              or
                AktuelleRasseStadt.Nummer = StadtKonstanten.LeerNummer
            then
               delay ZeitKonstanten.WartezeitGrafik;
                  
            else
               KarteStadt.AnzeigeStadt (StadtRasseNummerExtern => AktuelleRasseStadt);
            end if;
               
         when GrafikDatentypen.Grafik_Forschung_Enum =>
            AktuelleRasse := InteraktionGrafiktask.AktuelleRasseEinheit.Rasse;
            
            if
              AktuelleRasse = RassenDatentypen.Keine_Rasse_Enum
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikFehler (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Forschungsmenü wird ohne Rasse aufgerufen.");
                     
            else
               ForschungAnzeigeSFML.ForschungAnzeige;
            end if;
            
         when GrafikDatentypen.Grafik_Bauen_Enum =>
            AktuelleRasse := InteraktionGrafiktask.AktuelleRasseEinheit.Rasse;
            
            if
              AktuelleRasse = RassenDatentypen.Keine_Rasse_Enum
            then
               -- Da die Rasse schon auf der Weltkarte festgelegt wird, sollte dieser Fall niemals eintreten können. Beachten dass die Rasse zwischen den Zügen notwendig aber nicht festgelegt ist.
               Fehler.GrafikFehler (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Baumenü wird ohne Rasse aufgerufen.");
                     
            else
               BauAuswahlAnzeigeSFML.BauAuswahlAnzeige;
            end if;
         
         when GrafikDatentypen.Grafik_Ende_Enum =>
            return False;
      end case;
      
      AnzeigeEingaben;
      
      return True;
      
   end AnzeigeAuswahl;
   
   
   
   procedure AnzeigeEingaben
   is begin
      
      case
        InteraktionEingabe.Eingabe
      is
         when SystemDatentypen.Text_Eingabe_Enum =>
            AnzeigeEingabeSFML.AnzeigeText;
            
         when SystemDatentypen.Zahlen_Eingabe_Enum =>
            AnzeigeEingabeSFML.AnzeigeGanzeZahl;
            
         when SystemDatentypen.Einheit_Auswahl_Enum =>
            AktuelleRasse := InteraktionGrafiktask.AktuelleRasseEinheit.Rasse;
            
            if
              AktuelleRasse = RassenDatentypen.Keine_Rasse_Enum
            then
               null;
                     
            else
               AnzeigeEingabeSFML.AnzeigeEinheitenStadt (RasseExtern => AktuelleRasse);
            end if;
            
         when SystemDatentypen.Ja_Nein_Enum =>
            AnzeigeEingabeSFML.AnzeigeJaNein;
               
         when SystemDatentypen.Keine_Eingabe_Enum =>
            null;
      end case;
      
   end AnzeigeEingaben;
   
   
   
   procedure AnzeigeEditoren
   is begin
      
      null;
      
   end AnzeigeEditoren;

end GrafikSFML;
