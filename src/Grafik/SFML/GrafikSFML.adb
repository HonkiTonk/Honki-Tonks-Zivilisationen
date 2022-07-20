pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with GrafikDatentypen;
with ZeitKonstanten;

with Fehler;
with GrafikStartEndeSFML;
with GrafikIntroSFML;
with AuswahlMenuesSFML;
with Karte;
with NachGrafiktask;
with KarteStadt;
with GrafikAllgemeinSFML;
with Sichtweiten;
with ForschungAnzeigeSFML;
with AnzeigeSprachauswahlSFML;
with AnzeigeEingabeSFML;
with BauAuswahlAnzeigeSFML;
with NachLogiktask;
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
           NachGrafiktask.FensterGeschlossen
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
        NachGrafiktask.FensterVerändert
      is
         when GrafikDatentypen.Fenster_Wurde_Verändert_Enum'Range =>
            GrafikAllgemeinSFML.FensterAnpassen;
            Sichtweiten.SichtweiteBewegungsfeldFestlegen;
            NachGrafiktask.FensterVerändert := GrafikDatentypen.Keine_Änderung_Enum;
            
         when GrafikDatentypen.Bildrate_Ändern_Enum =>
            GrafikAllgemeinSFML.BildrateÄndern;
            NachGrafiktask.FensterVerändert := GrafikDatentypen.Keine_Änderung_Enum;
               
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
        NachGrafiktask.AktuelleDarstellung
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "GrafikSFML.AnzeigeAuswahl - Terminal wird bei SFML aufgerufen.");
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            NachLogiktask.FensterErzeugt := True;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            
         when GrafikDatentypen.Grafik_Sprache_Enum =>
            AnzeigeSprachauswahlSFML.AnzeigeSprache;
               
         when GrafikDatentypen.Grafik_Intro_Enum =>
            GrafikIntroSFML.Intro;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            NachLogiktask.Hauptmenü := True;
                              
         when GrafikDatentypen.Grafik_Pause_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            
         when GrafikDatentypen.Ladezeiten_Enum'Range =>
            LadezeitenSFML.LadezeitenSFML (WelcheLadeanzeigeExtern => NachGrafiktask.AktuelleDarstellung);
         
         when GrafikDatentypen.Grafik_Menüs_Enum =>
            AuswahlMenuesSFML.AuswahlMenüsAufteilung (WelchesMenüExtern => NachGrafiktask.AktuellesMenü);
               
         when GrafikDatentypen.Editoren_Anzeigen_Enum'Range =>
            AnzeigeEditoren;
               
         when GrafikDatentypen.Grafik_Weltkarte_Enum =>
            Karte.AnzeigeKarte (RasseEinheitExtern => (NachGrafiktask.AktuelleRasse, NachGrafiktask.AktuelleEinheit));
            
         when GrafikDatentypen.Grafik_Stadtkarte_Enum =>
            KarteStadt.AnzeigeStadt (StadtRasseNummerExtern => (NachGrafiktask.AktuelleRasse, NachGrafiktask.AktuelleStadt));
               
         when GrafikDatentypen.Grafik_Forschung_Enum =>
            ForschungAnzeigeSFML.ForschungAnzeige (RasseExtern => NachGrafiktask.AktuelleRasse);
            
         when GrafikDatentypen.Grafik_Bauen_Enum =>
            BauAuswahlAnzeigeSFML.BauAuswahlAnzeige (RasseExtern => NachGrafiktask.AktuelleRasse);
         
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
         when SystemDatentypen.Eingaben_Fragen_Enum'Range =>
            AnzeigeEingabeSFML.Fragenaufteilung (FrageExtern   => InteraktionEingabe.AnzeigeFrage,
                                                 EingabeExtern => InteraktionEingabe.Eingabe);
            
         when SystemDatentypen.Einheit_Auswahl_Enum =>
            AnzeigeEingabeSFML.AnzeigeEinheitenStadt (RasseExtern => NachGrafiktask.AktuelleRasse);
            
            -- Wenn ich das Baumenü/Forschungsmenü hierher verschiebe, dann könnte ich das Neusetzen vermeiden und diese Setzsachen in eine Prozedur auslagern. äöü
            -- Dann könnte ich auch ein durchsichtiges Fenster für die Menüs erstellen. äöü
            -- Könnte Probleme mit den anderen Möglichkeiten erzeugen, genauer prüfen vor dem Umbau. äöü
               
         when SystemDatentypen.Keine_Eingabe_Enum =>
            null;
      end case;
      
   end AnzeigeEingaben;
   
   
   
   procedure AnzeigeEditoren
   is begin
      
      null;
      
   end AnzeigeEditoren;

end GrafikSFML;
