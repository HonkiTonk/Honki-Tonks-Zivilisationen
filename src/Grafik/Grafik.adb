with GrafikDatentypen;
with ZeitKonstanten;
with SystemKonstanten;

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
      
      -- Aus irgendeinen Grund scheint das Windows zu brauchen, obwohl diese Werte bereits in StandardSpielwerteSetzenLogik.StandardspielwerteGrafik berechnet werden.
      -- Später (erst nach der Veröffentlichung von GNAT 13) mal nachprüfen warum. äöü
      -- Oder liegt das daran dass die Fenstergröße erst jetzt bekannt ist? Mal nachprüfen. äöü
      -- SichtweitenGrafik.KartenfelderAbmessungBerechnen;
      -- SichtweitenGrafik.StadtumgebungAbmessungBerechnen;
      
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
        NachGrafiktask.AccesseSetzen
      is
         when True =>
            TextaccesseSetzenGrafik.StandardSetzen;
            NachGrafiktask.AccesseSetzen := False;
               
         when False =>
            null;
      end case;
               
      case
        NachGrafiktask.FensterVerändert
      is
         when GrafikDatentypen.Fenster_Wurde_Verändert_Enum'Range =>
            FensterGrafik.FensterAnpassen;
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
      
      case
        NachGrafiktask.AktuelleDarstellung
      is
         when GrafikDatentypen.Grafik_Start_Enum =>
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            NachLogiktask.GrafikWarten := False;
            
            -- Wenn ich diese schreckliche Introlösung ersetze, dann die Sprachauswahl auch in die Menüs verschieben? äöü
         when GrafikDatentypen.Grafik_Sprache_Enum =>
            SprachauswahlGrafik.Sprachauswahl;
            Startzeit := Clock;
               
         when GrafikDatentypen.Grafik_Intro_Enum =>
            IntroGrafik.Intro;
            
            -- Später eine bessere Variante dafür bauen. äöü
            if
              Startzeit + ZeitKonstanten.Introzeit < Clock
              or
                NachGrafiktask.IntroAnzeigen = False
            then
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
               NachLogiktask.IntroAbwarten := False;
               
            else
               null;
            end if;
            
         when GrafikDatentypen.Grafik_Pause_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            
         when GrafikDatentypen.Ladezeiten_Enum'Range =>
            LadezeitenGrafik.Ladezeiten (WelcheLadeanzeigeExtern => NachGrafiktask.AktuelleDarstellung,
                                         SpeziesExtern           => NachGrafiktask.KIRechnet);
            -- Diese Prüfung kann nicht rausgezogen werden, da er mit dem aktuellen System sonst Tasteneingaben nicht mehr korrekt erkennt.
            TasteneingabeGrafik.FensterAnpassen;
         
         when GrafikDatentypen.Grafik_Menüs_Enum =>
            MenueaufteilungGrafik.Menüaufteilung (WelchesMenüExtern     => NachGrafiktask.AktuellesMenü,
                                                  AktuelleAuswahlExtern => NachGrafiktask.AktuelleAuswahl);
               
         when GrafikDatentypen.Grafik_Editoren_Enum =>
            EditorenGrafik.Editoren (WelcherEditorExtern => NachGrafiktask.WelcherEditor);
               
         when GrafikDatentypen.Grafik_Weltkarte_Enum =>
            KartenaufteilungGrafik.Weltkarte (EinheitenauswahlExtern => UebergabeRecordErmittelnGrafik.Einheit (EinheitSpeziesNummerExtern => (NachGrafiktask.AktuelleSpezies, NachGrafiktask.AktuelleEinheit)));
            
         when GrafikDatentypen.Grafik_Stadtkarte_Enum =>
            KartenaufteilungGrafik.Stadtkarte (StadtauswahlExtern => UebergabeRecordErmittelnGrafik.Stadt (StadtSpeziesNummerExtern => (NachGrafiktask.AktuelleSpezies, NachGrafiktask.AktuelleStadt)));
               
         when GrafikDatentypen.Grafik_Forschung_Enum =>
            ForschungsauswahlGrafik.ForschungAnzeige (SpeziesExtern         => NachGrafiktask.AktuelleSpezies,
                                                      AktuelleAuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Grafik_Forschung_Erfolgreich_Enum =>
            ForschungserfolgGrafik.Forschungserfolg (SpeziesExtern => NachGrafiktask.AktuelleSpezies,
                                                     AuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Grafik_Bauen_Enum =>
            BauauswahlGrafik.Bauauswahl (BauauswahlExtern      => UebergabeRecordErmittelnGrafik.Bauauswahl (StadtSpeziesNummerExtern => (NachGrafiktask.AktuelleSpezies, NachGrafiktask.AktuelleStadt)),
                                         AktuelleAuswahlExtern => NachGrafiktask.AktuelleBauauswahl);
            
         when GrafikDatentypen.Grafik_Verkaufen_Enum =>
            VerkaufsauswahlGrafik.Verkaufsauswahl (SpeziesExtern         => NachGrafiktask.AktuelleSpezies,
                                                   AktuelleAuswahlExtern => NachGrafiktask.AktuelleBauauswahl.Gebäude);
            
         when GrafikDatentypen.Grafik_Diplomatie_Enum =>
            DiplomatieauswahlGrafik.Diplomatieauswahl (AuswahlExtern => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
         when GrafikDatentypen.Grafik_Abspann_Enum =>
            AbspannGrafik.Abspann (AbspannExtern => NachGrafiktask.Abspannart,
                                   SpeziesExtern => NachGrafiktask.AktuelleSpezies);
            
         when GrafikDatentypen.Grafik_Ende_Enum =>
            return False;
      end case;
      
      -- Hier die Eingabe/Spielmeldung mitübergeben damit sie leichter verschiebbar sind? äöü
      AnzeigeSpielmeldungen;
      AnzeigeEingaben;
      
      return True;
      
   end AnzeigeAuswahl;
   
   
   
   procedure AnzeigeSpielmeldungen
   is begin
      
      case
        NachGrafiktask.Spielmeldung
      is
         when SystemKonstanten.LeerMeldung =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        Clock - NachGrafiktask.StartzeitSpielmeldung > ZeitKonstanten.AnzeigezeitSpielmeldungen
      then
         NachGrafiktask.Spielmeldung := SystemKonstanten.LeerMeldung;
         
      else
         SpielmeldungenGrafik.Spielmeldung (MeldungExtern => NachGrafiktask.Spielmeldung);
      end if;
            
   end AnzeigeSpielmeldungen;
   
   
   
   procedure AnzeigeEingaben
   is begin
      
      case
        NachGrafiktask.Eingabe
      is
         when GrafikDatentypen.Eingaben_Fragen_Enum'Range =>
            EingabenanzeigeGrafik.Fragenaufteilung (FrageExtern   => NachGrafiktask.AnzeigeFrage,
                                                    EingabeExtern => NachGrafiktask.Eingabe);
            
         when GrafikDatentypen.Einheit_Auswahl_Enum =>
            EingabenanzeigeGrafik.AnzeigeEinheitenStadt (SpeziesStadtnameExtern =>
                                                            UebergabeRecordErmittelnGrafik.SpeziesStadtname (StadtSpeziesNummerExtern => (NachGrafiktask.AktuelleSpezies, NachGrafiktask.AktuelleStadt)),
                                                         WelcheAuswahlExtern    => NachGrafiktask.WelcheAuswahl,
                                                         AktuelleAuswahlExtern  => NachGrafiktask.AktuelleAuswahl.AuswahlEins);
            
            -- Wenn ich das Baumenü/Forschungsmenü hierher verschiebe, dann könnte ich das Neusetzen vermeiden und diese Setzsachen in eine Prozedur auslagern. äöü
            -- Dann könnte ich auch ein durchsichtiges Fenster für die Menüs erstellen. äöü
            -- Könnte Probleme mit den anderen Möglichkeiten erzeugen, genauer prüfen vor dem Umbau. äöü
               
         when GrafikDatentypen.Keine_Eingabe_Enum =>
            null;
      end case;
      
   end AnzeigeEingaben;

end Grafik;
