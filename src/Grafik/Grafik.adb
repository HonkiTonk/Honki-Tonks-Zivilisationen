with ZeitKonstanten;
with SystemKonstanten;

with LeseEinstellungenGrafik;
with SchreibeLogiktask;
with LeseGrafiktask;
with SchreibeGrafiktask;
with Grafiktask;

with IntroGrafik;
with MenueaufteilungGrafik;
with FensterGrafik;
with SichtweitenGrafik;
with ForschungsauswahlGrafik;
with SprachauswahlGrafik;
with EingabenanzeigeGrafik;
with BauauswahlGrafik;
with TexteingabeGrafik;
with TextaccesseSetzenGrafik;
with LadezeitenGrafik;
with KartenaufteilungGrafik;
with DiplomatieauswahlGrafik;
with SpielmeldungenGrafik;
with EditorenGrafik;
with ForschungserfolgGrafik;
with TasteneingabeGrafik;
with AbspannGrafik;
with VerkaufsauswahlGrafik;
with UebergabeRecordErmittelnGrafik;
with TexteinstellungenGrafik;
with BildrateAnzeigenGrafik;
with TexturenauswahlGrafik;

-- with DiagnosesystemZusatzinformationen;

package body Grafik is
   
   procedure Grafik
   is begin
            
      GrafikStartenSchleife:
      while LeseGrafiktask.FensterErzeugen = False loop

         delay ZeitKonstanten.WartezeitGrafik;
         
      end loop GrafikStartenSchleife;
      
      -- Das Setzen der Schriftart kann scheinbar erst nach dem Erzeugen eines Fensters stattfinden.
      -- Oder habe ich zu dem Zeitpunkt den Font noch nicht eingelesen? Mal nachprüfen. äöü
      FensterGrafik.FensterErzeugen;
      TextaccesseSetzenGrafik.Texthöhe;
      
      -- DiagnosesystemZusatzinformationen.Größenprüfung;
      -- DiagnosesystemZusatzinformationen.GrößenprüfungDatei;
            
      Startzeit := Clock;
      
      GrafikSchleife:
      loop
         
         case
           LeseGrafiktask.FensterEntfernen
         is
            when True =>
               exit GrafikSchleife;
               
            when False =>
               GrafikanpassungenVorFensterleerung;
               FensterGrafik.FensterLeeren;
               Eingaben;
         end case;
         
         case
           AnzeigeAuswahl
         is
            when True =>
               FensterGrafik.FensterAnzeigen;
               
            when False =>
               exit GrafikSchleife;
         end case;
         
      end loop GrafikSchleife;
      
      FensterGrafik.FensterEntfernen;
      
   end Grafik;
   
   
   
   procedure GrafikanpassungenVorFensterleerung
   is begin
      
      case
        LeseGrafiktask.SchriftartSetzen
      is
         when True =>
            TexteinstellungenGrafik.SchriftartFestlegen;
            SchreibeGrafiktask.SchriftartSetzen (JaNeinExtern => False);
            
         when False =>
            null;
      end case;
      
      case
        LeseGrafiktask.SchriftgrößeSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftgröße;
            SchreibeGrafiktask.SchriftgrößeSetzen (JaNeinExtern => False);
            
         when False =>
            null;
      end case;
      
      case
        LeseGrafiktask.SchriftfarbeSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftfarbe;
            SchreibeGrafiktask.SchriftfarbeSetzen (JaNeinExtern => False);
            
         when False =>
            null;
      end case;
      
      case
        LeseGrafiktask.SchriftstilSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftstil;
            SchreibeGrafiktask.SchriftstilSetzen (JaNeinExtern => False);
            
         when False =>
            null;
      end case;
      
      case
        LeseGrafiktask.SchriftrahmenSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftrahmen;
            SchreibeGrafiktask.SchriftrahmenSetzen (JaNeinExtern => False);
            
         when False =>
            null;
      end case;
      
      case
        LeseGrafiktask.TextSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Text;
            SchreibeGrafiktask.TextSetzen (JaNeinExtern => False);
            
         when False =>
            null;
      end case;
               
      case
        LeseGrafiktask.FensterAnpassen
      is
         when GrafikDatentypen.Fenster_Wurde_Verändert_Enum'Range =>
            FensterGrafik.FensterAnpassen (FensterVerändertExtern => LeseGrafiktask.FensterAnpassen);
            SichtweitenGrafik.KartenfelderAbmessungBerechnen;
            SichtweitenGrafik.StadtumgebungAbmessungBerechnen;
            SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Keine_Änderung_Enum);
            SchreibeLogiktask.WartenGrafik (ZustandExtern => False);
            
         when GrafikDatentypen.Bildrate_Ändern_Enum =>
            FensterGrafik.BildrateÄndern;
            SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Keine_Änderung_Enum);
               
         when others =>
            null;
      end case;
      
   end GrafikanpassungenVorFensterleerung;
   
   
   
   procedure Eingaben
   is begin
      
      case
        LeseGrafiktask.Texteingabe
      is
         when True =>
            TexteingabeGrafik.Texteingabe;
               
         when False =>
            null;
      end case;
         
      case
        LeseGrafiktask.Tasteneingabe
      is
         when True =>
            TasteneingabeGrafik.Tasteneingabe;
               
         when False =>
            null;
      end case;
      
   end Eingaben;
   
   
   
   function AnzeigeAuswahl
     return Boolean
   is begin
      
      AktuelleDarstellung := LeseGrafiktask.Darstellung;
      
      case
        AktuelleDarstellung
      is
         when GrafikDatentypen.Start_Enum =>
            SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Pause_Enum);
            SchreibeLogiktask.WartenGrafik (ZustandExtern => False);
            
            -- Die Sprachauswahl auch in die Menüs schieben? äöü
         when GrafikDatentypen.Sprache_Enum =>
            SprachauswahlGrafik.Sprachauswahl;
            
         when GrafikDatentypen.Texturen_Enum =>
            TexturenauswahlGrafik.Texturenauswahl;
               
         when GrafikDatentypen.Intro_Enum =>
            IntroGrafik.Intro;
            
            if
              LeseGrafiktask.IntroBeenden = True
            then
               SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Pause_Enum);
               SchreibeLogiktask.WartenIntro (ZustandExtern => False);
               
            else
               null;
            end if;
            
         when GrafikDatentypen.Pause_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            
         when GrafikDatentypen.Ladezeiten_Enum'Range =>
            LadezeitenGrafik.Ladezeiten (WelcheLadeanzeigeExtern => AktuelleDarstellung,
                                         SpeziesExtern           => LeseGrafiktask.KIRechnet);
            -- Diese Prüfung kann nicht rausgezogen werden, da er mit dem aktuellen System sonst Tasteneingaben nicht mehr korrekt erkennt.
            TasteneingabeGrafik.FensterAnpassen;
         
         when GrafikDatentypen.Menüs_Enum =>
            MenueaufteilungGrafik.Menüaufteilung (WelchesMenüExtern     => LeseGrafiktask.Menü,
                                                   AktuelleAuswahlExtern => (LeseGrafiktask.Erstauswahl, LeseGrafiktask.Zweitauswahl));
               
         when GrafikDatentypen.Editoren_Enum =>
            EditorenGrafik.Editoren (WelcherEditorExtern => LeseGrafiktask.Editorart);
               
         when GrafikDatentypen.Weltkarte_Enum =>
            KartenaufteilungGrafik.Weltkarte (EinheitenauswahlExtern => UebergabeRecordErmittelnGrafik.Einheit (EinheitSpeziesNummerExtern => (LeseGrafiktask.AktiveSpezies, LeseGrafiktask.Einheitnummer)));
            
         when GrafikDatentypen.Stadt_Enum'Range =>
            KartenaufteilungGrafik.Stadtkarte (StadtauswahlExtern => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => (LeseGrafiktask.AktiveSpezies, LeseGrafiktask.Stadtnummer)),
                                               AnzeigeExtern      => AktuelleDarstellung);
               
         when GrafikDatentypen.Forschung_Enum =>
            ForschungsauswahlGrafik.ForschungAnzeige (SpeziesExtern         => LeseGrafiktask.AktiveSpezies,
                                                      AktuelleAuswahlExtern => LeseGrafiktask.Erstauswahl);
            
         when GrafikDatentypen.Forschungserfolg_Enum =>
            ForschungserfolgGrafik.Forschungserfolg (SpeziesExtern => LeseGrafiktask.AktiveSpezies,
                                                     AuswahlExtern => LeseGrafiktask.Erstauswahl);
            
         when GrafikDatentypen.Bauen_Enum =>
            BauauswahlGrafik.Bauauswahl (BauauswahlExtern         => UebergabeRecordErmittelnGrafik.Bauauswahl (StadtSpeziesNummerExtern => (LeseGrafiktask.AktiveSpezies, LeseGrafiktask.Stadtnummer)),
                                         AktuelleAuswahlExtern    => (LeseGrafiktask.Gebäudeauswahl, LeseGrafiktask.Einheitenauswahl, Grafiktask.Auswahl.Bauauswahl.Bauprojektart),
                                         AktuelleAufteilungExtern => Grafiktask.WelchesBaumenü);
            
         when GrafikDatentypen.Verkaufen_Enum =>
            VerkaufsauswahlGrafik.Verkaufsauswahl (SpeziesExtern         => LeseGrafiktask.AktiveSpezies,
                                                   AktuelleAuswahlExtern => LeseGrafiktask.Gebäudeauswahl);
            
         when GrafikDatentypen.Diplomatie_Enum =>
            DiplomatieauswahlGrafik.Diplomatieauswahl (AuswahlExtern => LeseGrafiktask.Erstauswahl);
            
         when GrafikDatentypen.Abspann_Enum =>
            AbspannGrafik.Abspann (AbspannExtern => LeseGrafiktask.Abspann,
                                   SpeziesExtern => LeseGrafiktask.AktiveSpezies);
            
         when GrafikDatentypen.Ende_Enum =>
            return False;
      end case;
      
      AnzeigeSpielmeldungen (AktuelleDarstellungExtern => AktuelleDarstellung,
                             LetzteDarstellungExtern   => LetzteDarstellung,
                             SpielmeldungExtern        => LeseGrafiktask.Spielmeldung);
      
      AnzeigeEingaben (EingabeExtern => LeseGrafiktask.Eingabeart,
                       FrageExtern   => LeseGrafiktask.Fragenanzeige);
                             
      case
        LeseEinstellungenGrafik.BildrateAnzeigen
      is
         when True =>
            BildrateAnzeigenGrafik.Bildrate;
            
         when False =>
            null;
      end case;
      
      LetzteDarstellung := AktuelleDarstellung;
      
      return True;
      
   end AnzeigeAuswahl;
   
   
   
   procedure AnzeigeSpielmeldungen
     (AktuelleDarstellungExtern : in GrafikDatentypen.Aktuelle_Anzeige_Enum;
      LetzteDarstellungExtern : in GrafikDatentypen.Aktuelle_Anzeige_Enum;
      SpielmeldungExtern : in TextnummernKonstanten.Spielmeldungen)
   is
      use type GrafikDatentypen.Aktuelle_Anzeige_Enum;
   begin
      
      if
        SpielmeldungExtern = SystemKonstanten.LeerMeldung 
      then
         null;
      
      elsif
        LetzteDarstellungExtern /= AktuelleDarstellungExtern
      then
         SchreibeGrafiktask.Spielmeldung (MeldungExtern => SystemKonstanten.LeerMeldung);
      
      elsif
        Clock - LeseGrafiktask.Spielmeldungszeit > ZeitKonstanten.AnzeigezeitSpielmeldungen
      then
         SchreibeGrafiktask.Spielmeldung (MeldungExtern => SystemKonstanten.LeerMeldung);
         
      else
         SpielmeldungenGrafik.Spielmeldung (MeldungExtern => SpielmeldungExtern);
      end if;
      
   end AnzeigeSpielmeldungen;
   
   
   
   procedure AnzeigeEingaben
     (EingabeExtern : in GrafikDatentypen.Eingabe_Enum;
      FrageExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      case
        EingabeExtern
      is
         when GrafikDatentypen.Eingabe_Fragen_Enum'Range =>
            if
              FrageExtern /= 0
            then
               EingabenanzeigeGrafik.Fragenaufteilung (FrageExtern   => FrageExtern,
                                                       EingabeExtern => EingabeExtern);
               
            else
               null;
            end if;
            
         when GrafikDatentypen.Einheit_Auswahl_Enum =>
            EingabenanzeigeGrafik.AnzeigeEinheitenStadt (SpeziesStadtnameExtern => UebergabeRecordErmittelnGrafik.SpeziesStadtname (StadtSpeziesNummerExtern => (LeseGrafiktask.AktiveSpezies, LeseGrafiktask.Stadtnummer)),
                                                         WelcheAuswahlExtern    => LeseGrafiktask.StadtEinheitAuswahl,
                                                         AktuelleAuswahlExtern  => LeseGrafiktask.Erstauswahl);
            
            -- Wenn ich das Baumenü/Forschungsmenü hierher verschiebe, dann könnte ich das Neusetzen vermeiden und diese Setzsachen in eine Prozedur auslagern. äöü
            -- Dann könnte ich auch ein durchsichtiges Fenster für die Menüs erstellen. äöü
            -- Könnte Probleme mit den anderen Möglichkeiten erzeugen, genauer prüfen vor dem Umbau. äöü
               
         when GrafikDatentypen.Keine_Eingabe_Enum =>
            null;
      end case;
      
   end AnzeigeEingaben;

end Grafik;
