with ZeitKonstanten;
with SystemKonstanten;

with LeseEinstellungenGrafik;
with SchreibeLogiktask;

with IntroGrafik;
with MenueaufteilungGrafik;
with Grafiktask;
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

-- with Diagnoseinformationen;

package body Grafik is
   
   procedure Grafik
   is begin
            
      GrafikStartenSchleife:
      while Grafiktask.Spielstart.ErzeugeFenster = False loop

         delay ZeitKonstanten.WartezeitGrafik;
         
      end loop GrafikStartenSchleife;
      
      -- Das Setzen der Schriftart kann scheinbar erst nach dem Erzeugen eines Fensters stattfinden.
      -- Oder habe ich zu dem Zeitpunkt den Font noch nicht eingelesen? Mal nachprüfen. äöü
      FensterGrafik.FensterErzeugen;
      
      -- Diagnoseinformationen.Größenprüfung;
      
      Startzeit := Clock;
      
      GrafikSchleife:
      loop
                  
         case
           Grafiktask.Grafik.FensterGeschlossen
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
        Grafiktask.Texteinstellungen.SchriftartSetzen
      is
         when True =>
            TexteinstellungenGrafik.SchriftartFestlegen;
            Grafiktask.Texteinstellungen.SchriftartSetzen := False;
            
         when False =>
            null;
      end case;
      
      case
        Grafiktask.Texteinstellungen.SchriftgrößeSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftgröße;
            Grafiktask.Texteinstellungen.SchriftgrößeSetzen := False;
            
         when False =>
            null;
      end case;
      
      case
        Grafiktask.Texteinstellungen.SchriftfarbeSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftfarbe;
            Grafiktask.Texteinstellungen.SchriftfarbeSetzen := False;
            
         when False =>
            null;
      end case;
      
      case
        Grafiktask.Texteinstellungen.SchriftstilSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftstil;
            Grafiktask.Texteinstellungen.SchriftstilSetzen := False;
            
         when False =>
            null;
      end case;
      
      case
        Grafiktask.Texteinstellungen.TextSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Text;
            Grafiktask.Texteinstellungen.TextSetzen := False;
            
         when False =>
            null;
      end case;
               
      case
        Grafiktask.Grafik.FensterVerändert
      is
         when GrafikDatentypen.Fenster_Wurde_Verändert_Enum'Range =>
            FensterGrafik.FensterAnpassen (FensterVerändertExtern => Grafiktask.Grafik.FensterVerändert);
            SichtweitenGrafik.KartenfelderAbmessungBerechnen;
            SichtweitenGrafik.StadtumgebungAbmessungBerechnen;
            Grafiktask.Grafik.FensterVerändert := GrafikDatentypen.Keine_Änderung_Enum;
            SchreibeLogiktask.WartenGrafik (ZustandExtern => False);
            
         when GrafikDatentypen.Bildrate_Ändern_Enum =>
            FensterGrafik.BildrateÄndern;
            Grafiktask.Grafik.FensterVerändert := GrafikDatentypen.Keine_Änderung_Enum;
               
         when others =>
            null;
      end case;
      
   end GrafikanpassungenVorFensterleerung;
   
   
   
   procedure Eingaben
   is begin
      
      case
        Grafiktask.Eingaben.TextEingabe
      is
         when True =>
            TexteingabeGrafik.Texteingabe;
               
         when False =>
            null;
      end case;
         
      case
        Grafiktask.Eingaben.TastenEingabe
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
      
      AktuelleDarstellung := Grafiktask.Grafik.AktuelleDarstellung;
      
      case
        AktuelleDarstellung
      is
         when GrafikDatentypen.Start_Enum =>
            Grafiktask.Grafik.AktuelleDarstellung := GrafikDatentypen.Pause_Enum;
            SchreibeLogiktask.WartenGrafik (ZustandExtern => False);
            
            -- Wenn ich diese schreckliche Introlösung ersetze, dann die Sprachauswahl auch in die Menüs verschieben? äöü
         when GrafikDatentypen.Sprache_Enum =>
            SprachauswahlGrafik.Sprachauswahl;
            Startzeit := Clock;
               
         when GrafikDatentypen.Intro_Enum =>
            IntroGrafik.Intro;
            
            -- Später eine bessere Variante dafür bauen. äöü
            if
              Startzeit + ZeitKonstanten.Introzeit < Clock
              or
                Grafiktask.Spielstart.IntroBeenden = True
            then
               Grafiktask.Grafik.AktuelleDarstellung := GrafikDatentypen.Pause_Enum;
               SchreibeLogiktask.WartenIntro (ZustandExtern => False);
               
            else
               null;
            end if;
            
         when GrafikDatentypen.Pause_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            
         when GrafikDatentypen.Ladezeiten_Enum'Range =>
            LadezeitenGrafik.Ladezeiten (WelcheLadeanzeigeExtern => Grafiktask.Grafik.AktuelleDarstellung,
                                         SpeziesExtern           => Grafiktask.Aktuelles.KIRechnet);
            -- Diese Prüfung kann nicht rausgezogen werden, da er mit dem aktuellen System sonst Tasteneingaben nicht mehr korrekt erkennt.
            TasteneingabeGrafik.FensterAnpassen;
         
         when GrafikDatentypen.Menüs_Enum =>
            MenueaufteilungGrafik.Menüaufteilung (WelchesMenüExtern     => Grafiktask.Grafik.AktuellesMenü,
                                                   AktuelleAuswahlExtern => Grafiktask.Auswahl.AktuelleAuswahl);
               
         when GrafikDatentypen.Editoren_Enum =>
            EditorenGrafik.Editoren (WelcherEditorExtern => Grafiktask.Editoren.WelcherEditor);
               
         when GrafikDatentypen.Weltkarte_Enum =>
            KartenaufteilungGrafik.Weltkarte (EinheitenauswahlExtern => UebergabeRecordErmittelnGrafik.Einheit (EinheitSpeziesNummerExtern
                                              => (Grafiktask.Aktuelles.AktuelleSpezies, Grafiktask.Aktuelles.AktuelleEinheit)));
            
         when GrafikDatentypen.Stadtkarte_Enum =>
            KartenaufteilungGrafik.Stadtkarte (StadtauswahlExtern => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => (Grafiktask.Aktuelles.AktuelleSpezies, Grafiktask.Aktuelles.AktuelleStadt)));
               
         when GrafikDatentypen.Forschung_Enum =>
            ForschungsauswahlGrafik.ForschungAnzeige (SpeziesExtern         => Grafiktask.Aktuelles.AktuelleSpezies,
                                                      AktuelleAuswahlExtern => Grafiktask.Auswahl.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Forschungserfolg_Enum =>
            ForschungserfolgGrafik.Forschungserfolg (SpeziesExtern => Grafiktask.Aktuelles.AktuelleSpezies,
                                                     AuswahlExtern => Grafiktask.Auswahl.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Bauen_Enum =>
            BauauswahlGrafik.Bauauswahl (BauauswahlExtern      => UebergabeRecordErmittelnGrafik.Bauauswahl (StadtSpeziesNummerExtern => (Grafiktask.Aktuelles.AktuelleSpezies, Grafiktask.Aktuelles.AktuelleStadt)),
                                         AktuelleAuswahlExtern => Grafiktask.Auswahl.Bauauswahl);
            
         when GrafikDatentypen.Verkaufen_Enum =>
            VerkaufsauswahlGrafik.Verkaufsauswahl (SpeziesExtern         => Grafiktask.Aktuelles.AktuelleSpezies,
                                                   AktuelleAuswahlExtern => Grafiktask.Auswahl.Bauauswahl.Gebäude);
            
         when GrafikDatentypen.Diplomatie_Enum =>
            DiplomatieauswahlGrafik.Diplomatieauswahl (AuswahlExtern => Grafiktask.Auswahl.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Abspann_Enum =>
            AbspannGrafik.Abspann (AbspannExtern => Grafiktask.Grafik.Abspannart,
                                   SpeziesExtern => Grafiktask.Aktuelles.AktuelleSpezies);
            
         when GrafikDatentypen.Ende_Enum =>
            return False;
      end case;
      
      AnzeigeSpielmeldungen (AktuelleDarstellungExtern => AktuelleDarstellung,
                             LetzteDarstellungExtern   => LetzteDarstellung,
                             SpielmeldungExtern        => Grafiktask.Meldungen.Spielmeldung);
      
      AnzeigeEingaben (EingabeExtern => Grafiktask.Eingaben.Eingabeart);
                             
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
     (AktuelleDarstellungExtern : in GrafikDatentypen.AKtuelle_Anzeige_Enum;
      LetzteDarstellungExtern : in GrafikDatentypen.AKtuelle_Anzeige_Enum;
      SpielmeldungExtern : in TextnummernKonstanten.Spielmeldungen)
   is
      use type GrafikDatentypen.AKtuelle_Anzeige_Enum;
   begin
      
      if
        SpielmeldungExtern = SystemKonstanten.LeerMeldung 
      then
         null;
      
      elsif
        LetzteDarstellungExtern /= AktuelleDarstellungExtern
      then
         Grafiktask.Meldungen.Spielmeldung := SystemKonstanten.LeerMeldung;
      
      elsif
        Clock - Grafiktask.Meldungen.StartzeitSpielmeldung > ZeitKonstanten.AnzeigezeitSpielmeldungen
      then
         Grafiktask.Meldungen.Spielmeldung := SystemKonstanten.LeerMeldung;
         
      else
         SpielmeldungenGrafik.Spielmeldung (MeldungExtern => SpielmeldungExtern);
      end if;
      
   end AnzeigeSpielmeldungen;
   
   
   
   procedure AnzeigeEingaben
     (EingabeExtern : in GrafikDatentypen.Eingabe_Enum)
   is begin
      
      case
        EingabeExtern
      is
         when GrafikDatentypen.Eingabe_Fragen_Enum'Range =>
            EingabenanzeigeGrafik.Fragenaufteilung (FrageExtern   => Grafiktask.Meldungen.AnzeigeFrage,
                                                    EingabeExtern => EingabeExtern);
            
         when GrafikDatentypen.Einheit_Auswahl_Enum =>
            EingabenanzeigeGrafik.AnzeigeEinheitenStadt (SpeziesStadtnameExtern =>
                                                            UebergabeRecordErmittelnGrafik.SpeziesStadtname (StadtSpeziesNummerExtern => (Grafiktask.Aktuelles.AktuelleSpezies, Grafiktask.Aktuelles.AktuelleStadt)),
                                                         WelcheAuswahlExtern    => Grafiktask.Auswahl.StadtEinheitAuswahl,
                                                         AktuelleAuswahlExtern  => Grafiktask.Auswahl.AktuelleAuswahl.AuswahlEins);
            
            -- Wenn ich das Baumenü/Forschungsmenü hierher verschiebe, dann könnte ich das Neusetzen vermeiden und diese Setzsachen in eine Prozedur auslagern. äöü
            -- Dann könnte ich auch ein durchsichtiges Fenster für die Menüs erstellen. äöü
            -- Könnte Probleme mit den anderen Möglichkeiten erzeugen, genauer prüfen vor dem Umbau. äöü
               
         when GrafikDatentypen.Keine_Eingabe_Enum =>
            null;
      end case;
      
   end AnzeigeEingaben;

end Grafik;
