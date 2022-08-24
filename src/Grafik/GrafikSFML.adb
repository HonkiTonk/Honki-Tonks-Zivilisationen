pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with GrafikDatentypen; use GrafikDatentypen;
with SystemDatentypen;
with ZeitKonstanten;

with GrafikStartEndeSFML;
with GrafikIntroSFML;
with AuswahlMenuesSFML;
with NachGrafiktask;
with GrafikAllgemeinSFML;
with Sichtweiten;
with ForschungAnzeigeSFML;
with AnzeigeSprachauswahlSFML;
with AnzeigeEingabeSFML;
with BauAuswahlAnzeigeSFML;
with NachLogiktask;
with EingabeSystemeSFML;
with TextaccesseAllesSetzenSFML;
with LadezeitenSFML;
with KartenaufteilungSFML;

package body GrafikSFML is
   
   procedure GrafikSFML
   is begin
      
      GrafikStartenSchleife:
      while NachGrafiktask.ErzeugeFenster = False loop

         delay ZeitKonstanten.WartezeitGrafik;
         
      end loop GrafikStartenSchleife;
      
      -- Das Setzen der Schriftart kann scheinbar erst nach dem Erzeugen eines Fensters stattfinden.
      -- Oder habe ich zu dem Zeitpunkt den Font noch nicht eingelesen? Mal nachprüfen. äöü
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
        NachGrafiktask.AccesseSetzen
      is
         when True =>
            TextaccesseAllesSetzenSFML.AllesAufStandard;
            NachGrafiktask.AccesseSetzen := False;
               
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
            NachLogiktask.Warten := False;
            
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
        NachGrafiktask.TextEingabe
      is
         when True =>
            EingabeSystemeSFML.TextEingeben;
               
         when False =>
            null;
      end case;
         
      case
        NachGrafiktask.TastenEingabe
      is
         when True =>
            EingabeSystemeSFML.TastenEingabe;
               
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
         when GrafikDatentypen.Grafik_Start_Enum =>
            NachLogiktask.Warten := False;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            
         when GrafikDatentypen.Grafik_Sprache_Enum =>
            AnzeigeSprachauswahlSFML.AnzeigeSprache;
               
         when GrafikDatentypen.Grafik_Intro_Enum =>
            GrafikIntroSFML.Intro;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            NachLogiktask.Warten := False;
            
         when GrafikDatentypen.Grafik_Pause_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            
         when GrafikDatentypen.Ladezeiten_Enum'Range =>
            LadezeitenSFML.LadezeitenSFML (WelcheLadeanzeigeExtern => NachGrafiktask.AktuelleDarstellung,
                                           RasseExtern             => NachGrafiktask.KIRechnet);
         
         when GrafikDatentypen.Grafik_Menüs_Enum =>
            AuswahlMenuesSFML.AuswahlMenüsAufteilung (WelchesMenüExtern     => NachGrafiktask.AktuellesMenü,
                                                      AktuelleAuswahlExtern => NachGrafiktask.AktuelleAuswahl);
               
         when GrafikDatentypen.Editoren_Anzeigen_Enum'Range =>
            AnzeigeEditoren;
               
         when GrafikDatentypen.Grafik_Weltkarte_Enum =>
            KartenaufteilungSFML.Weltkarte (EinheitRasseNummerExtern => (NachGrafiktask.AktuelleRasse, NachGrafiktask.AktuelleEinheit));
            
         when GrafikDatentypen.Grafik_Stadtkarte_Enum =>
            KartenaufteilungSFML.Stadtkarte (StadtRasseNummerExtern => (NachGrafiktask.AktuelleRasse, NachGrafiktask.AktuelleStadt));
               
         when GrafikDatentypen.Grafik_Forschung_Enum =>
            ForschungAnzeigeSFML.ForschungAnzeige (RasseExtern           => NachGrafiktask.AktuelleRasse,
                                                   AktuelleAuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Grafik_Bauen_Enum =>
            BauAuswahlAnzeigeSFML.BauAuswahlAnzeige (StadtRasseNummerExtern => (NachGrafiktask.AktuelleRasse, NachGrafiktask.AktuelleStadt),
                                                     AktuelleAuswahlExtern  => NachGrafiktask.AktuelleBauauswahl);
         
         when GrafikDatentypen.Grafik_Ende_Enum =>
            return False;
      end case;
      
      AnzeigeEingaben;
      AnzeigeSpielmeldungen;
      
      return True;
      
   end AnzeigeAuswahl;
   
   
   
   procedure AnzeigeEingaben
   is begin
      
      case
        NachGrafiktask.Eingabe
      is
         when SystemDatentypen.Eingaben_Fragen_Enum'Range =>
            AnzeigeEingabeSFML.Fragenaufteilung (FrageExtern   => NachGrafiktask.AnzeigeFrage,
                                                 EingabeExtern => NachGrafiktask.Eingabe);
            
         when SystemDatentypen.Einheit_Auswahl_Enum =>
            AnzeigeEingabeSFML.AnzeigeEinheitenStadt (RasseExtern => NachGrafiktask.AktuelleRasse);
            
            -- Wenn ich das Baumenü/Forschungsmenü hierher verschiebe, dann könnte ich das Neusetzen vermeiden und diese Setzsachen in eine Prozedur auslagern. äöü
            -- Dann könnte ich auch ein durchsichtiges Fenster für die Menüs erstellen. äöü
            -- Könnte Probleme mit den anderen Möglichkeiten erzeugen, genauer prüfen vor dem Umbau. äöü
               
         when SystemDatentypen.Keine_Eingabe_Enum =>
            null;
      end case;
      
   end AnzeigeEingaben;
   
   
   
   procedure AnzeigeSpielmeldungen
   is begin
      
      case
        NachGrafiktask.Spielmeldung
      is
         when 0 =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        Clock - NachGrafiktask.StartzeitSpielmeldung > ZeitKonstanten.AnzeigezeitSpielmeldungen
      then
         NachGrafiktask.Spielmeldung := 0;
         
      else
         null;
      end if;
            
   end AnzeigeSpielmeldungen;
   
   
   
   procedure AnzeigeEditoren
   is begin
      
      null;
      
   end AnzeigeEditoren;

end GrafikSFML;
