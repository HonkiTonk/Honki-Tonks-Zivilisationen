with ZeitKonstanten;
with SystemKonstanten;

with LeseEinstellungenGrafik;

with IntroGrafik;
with MenueaufteilungGrafik;
with NachGrafiktask;
with FensterGrafik;
with SichtweitenGrafik;
with ForschungsauswahlGrafik;
with SprachauswahlGrafik;
with EingabenanzeigeGrafik;
with BauauswahlGrafik;
with NachLogiktask;
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
      while NachGrafiktask.ErzeugeFenster = False loop

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
           NachGrafiktask.FensterGeschlossen
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
        NachGrafiktask.Texteinstellungen.SchriftartSetzen
      is
         when True =>
            TexteinstellungenGrafik.SchriftartFestlegen;
            NachGrafiktask.Texteinstellungen.SchriftartSetzen := False;
            
         when False =>
            null;
      end case;
      
      case
        NachGrafiktask.Texteinstellungen.SchriftgrößeSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftgröße;
            NachGrafiktask.Texteinstellungen.SchriftgrößeSetzen := False;
            
         when False =>
            null;
      end case;
      
      case
        NachGrafiktask.Texteinstellungen.SchriftfarbeSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftfarbe;
            NachGrafiktask.Texteinstellungen.SchriftfarbeSetzen := False;
            
         when False =>
            null;
      end case;
      
      case
        NachGrafiktask.Texteinstellungen.SchriftstilSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Schriftstil;
            NachGrafiktask.Texteinstellungen.SchriftstilSetzen := False;
            
         when False =>
            null;
      end case;
      
      case
        NachGrafiktask.Texteinstellungen.TextSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.Text;
            NachGrafiktask.Texteinstellungen.TextSetzen := False;
            
         when False =>
            null;
      end case;
               
      case
        NachGrafiktask.FensterVerändert
      is
         when GrafikDatentypen.Fenster_Wurde_Verändert_Enum'Range =>
            FensterGrafik.FensterAnpassen (FensterVerändertExtern => NachGrafiktask.FensterVerändert);
            SichtweitenGrafik.KartenfelderAbmessungBerechnen;
            SichtweitenGrafik.StadtumgebungAbmessungBerechnen;
            NachGrafiktask.FensterVerändert := GrafikDatentypen.Keine_Änderung_Enum;
            NachLogiktask.GrafikWarten := False;
            
         when GrafikDatentypen.Bildrate_Ändern_Enum =>
            FensterGrafik.BildrateÄndern;
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
            TexteingabeGrafik.Texteingabe;
               
         when False =>
            null;
      end case;
         
      case
        NachGrafiktask.TastenEingabe
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
      
      AktuelleDarstellung := NachGrafiktask.AktuelleDarstellung;
      
      case
        AktuelleDarstellung
      is
         when GrafikDatentypen.Start_Enum =>
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Pause_Enum;
            NachLogiktask.GrafikWarten := False;
            
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
                NachGrafiktask.IntroAnzeigen = False
            then
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Pause_Enum;
               NachLogiktask.IntroAbwarten := False;
               
            else
               null;
            end if;
            
         when GrafikDatentypen.Pause_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            
         when GrafikDatentypen.Ladezeiten_Enum'Range =>
            LadezeitenGrafik.Ladezeiten (WelcheLadeanzeigeExtern => NachGrafiktask.AktuelleDarstellung,
                                         SpeziesExtern           => NachGrafiktask.KIRechnet);
            -- Diese Prüfung kann nicht rausgezogen werden, da er mit dem aktuellen System sonst Tasteneingaben nicht mehr korrekt erkennt.
            TasteneingabeGrafik.FensterAnpassen;
         
         when GrafikDatentypen.Menüs_Enum =>
            MenueaufteilungGrafik.Menüaufteilung (WelchesMenüExtern     => NachGrafiktask.AktuellesMenü,
                                                   AktuelleAuswahlExtern => NachGrafiktask.AktuelleAuswahl);
               
         when GrafikDatentypen.Editoren_Enum =>
            EditorenGrafik.Editoren (WelcherEditorExtern => NachGrafiktask.WelcherEditor);
               
         when GrafikDatentypen.Weltkarte_Enum =>
            KartenaufteilungGrafik.Weltkarte (EinheitenauswahlExtern => UebergabeRecordErmittelnGrafik.Einheit (EinheitSpeziesNummerExtern => (NachGrafiktask.AktuelleSpezies, NachGrafiktask.AktuelleEinheit)));
            
         when GrafikDatentypen.Stadtkarte_Enum =>
            KartenaufteilungGrafik.Stadtkarte (StadtauswahlExtern => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => (NachGrafiktask.AktuelleSpezies, NachGrafiktask.AktuelleStadt)));
               
         when GrafikDatentypen.Forschung_Enum =>
            ForschungsauswahlGrafik.ForschungAnzeige (SpeziesExtern         => NachGrafiktask.AktuelleSpezies,
                                                      AktuelleAuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Forschungserfolg_Enum =>
            ForschungserfolgGrafik.Forschungserfolg (SpeziesExtern => NachGrafiktask.AktuelleSpezies,
                                                     AuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Bauen_Enum =>
            BauauswahlGrafik.Bauauswahl (BauauswahlExtern      => UebergabeRecordErmittelnGrafik.Bauauswahl (StadtSpeziesNummerExtern => (NachGrafiktask.AktuelleSpezies, NachGrafiktask.AktuelleStadt)),
                                         AktuelleAuswahlExtern => NachGrafiktask.AktuelleBauauswahl);
            
         when GrafikDatentypen.Verkaufen_Enum =>
            VerkaufsauswahlGrafik.Verkaufsauswahl (SpeziesExtern         => NachGrafiktask.AktuelleSpezies,
                                                   AktuelleAuswahlExtern => NachGrafiktask.AktuelleBauauswahl.Gebäude);
            
         when GrafikDatentypen.Diplomatie_Enum =>
            DiplomatieauswahlGrafik.Diplomatieauswahl (AuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Abspann_Enum =>
            AbspannGrafik.Abspann (AbspannExtern => NachGrafiktask.Abspannart,
                                   SpeziesExtern => NachGrafiktask.AktuelleSpezies);
            
         when GrafikDatentypen.Ende_Enum =>
            return False;
      end case;
      
      AnzeigeSpielmeldungen (AktuelleDarstellungExtern => AktuelleDarstellung,
                             LetzteDarstellungExtern   => LetzteDarstellung,
                             SpielmeldungExtern        => NachGrafiktask.Spielmeldung);
      
      AnzeigeEingaben (EingabeExtern => NachGrafiktask.Eingabe);
                             
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
         NachGrafiktask.Spielmeldung := SystemKonstanten.LeerMeldung;
      
      elsif
        Clock - NachGrafiktask.StartzeitSpielmeldung > ZeitKonstanten.AnzeigezeitSpielmeldungen
      then
         NachGrafiktask.Spielmeldung := SystemKonstanten.LeerMeldung;
         
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
            EingabenanzeigeGrafik.Fragenaufteilung (FrageExtern   => NachGrafiktask.AnzeigeFrage,
                                                    EingabeExtern => EingabeExtern);
            
         when GrafikDatentypen.Einheit_Auswahl_Enum =>
            EingabenanzeigeGrafik.AnzeigeEinheitenStadt (SpeziesStadtnameExtern =>
                                                            UebergabeRecordErmittelnGrafik.SpeziesStadtname (StadtSpeziesNummerExtern => (NachGrafiktask.AktuelleSpezies, NachGrafiktask.AktuelleStadt)),
                                                         WelcheAuswahlExtern    => NachGrafiktask.StadtEinheitAuswahl,
                                                         AktuelleAuswahlExtern  => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
            -- Wenn ich das Baumenü/Forschungsmenü hierher verschiebe, dann könnte ich das Neusetzen vermeiden und diese Setzsachen in eine Prozedur auslagern. äöü
            -- Dann könnte ich auch ein durchsichtiges Fenster für die Menüs erstellen. äöü
            -- Könnte Probleme mit den anderen Möglichkeiten erzeugen, genauer prüfen vor dem Umbau. äöü
               
         when GrafikDatentypen.Keine_Eingabe_Enum =>
            null;
      end case;
      
   end AnzeigeEingaben;

end Grafik;
