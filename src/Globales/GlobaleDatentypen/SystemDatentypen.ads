pragma SPARK_Mode (On);

package SystemDatentypen is

   -- Wichtige Werte
   type Rückgabe_Werte_Enum is (Leer, Start_Weiter, Zurück, Hauptmenü, Spiel_Beenden, Ja, Nein, Speichern, Laden, Optionen, Informationen, Wiederherstellen, Würdigungen, Runde_Beenden, Sieg, Vernichtung, Zufall, Eingabe,
                                 Rasse_Entfernen, Grafik, Sound, Steuerung, Sonstiges, Fertig, Schleife_Verlassen, Anzahl_Speicherstände, Runden_Bis_Autospeichern, Sprache, Spielmenü,
                                 
                                 -- Grafikmenü
                                 Auflösung_Ändern, Farbtiefe_Ändern, Bildrate_Ändern, Schriftgröße,
                                 
                                 -- Soundmenü
                                 
                                 
                                 -- Karteneinstellungen
                                 Auswahl_Kartengröße, Auswahl_Kartenart, Auswahl_Kartenform, Auswahl_Kartentemperatur, Auswahl_Rassen, Auswahl_Schwierigkeitsgrad, Auswahl_Kartenressourcen,
                                 
                                 Karte_Größe_20_20, Karte_Größe_40_40, Karte_Größe_80_80, Karte_Größe_120_80, Karte_Größe_120_160, Karte_Größe_160_160, Karte_Größe_240_240, Karte_Größe_320_320, Karte_Größe_1000_1000,
                                 Karte_Größe_Nutzer, Karte_Größe_Zufall,
                                
                                 -- Neue Kartenarten immer vor Chaos einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 Karte_Art_Inseln, Karte_Art_Kontinente, Karte_Art_Pangäa, Karte_Art_Nur_Land, Karte_Art_Chaos,
                                
                                 -- Neue Kartenformen immer vor Tugel Extrem einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 Karte_Form_X_Zylinder, Karte_Form_Y_Zylinder, Karte_Form_Torus, Karte_Form_Kugel, Karte_Form_Viereck, Karte_Form_Kugel_Gedreht, Karte_Form_Tugel, Karte_Form_Tugel_Gedreht,
                                 Karte_Form_Tugel_Extrem,
                                
                                 -- Neue Kartentemperaturen immer vor Wüste einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 Karte_Temperatur_Kalt, Karte_Temperatur_Gemäßigt, Karte_Temperatur_Heiß, Karte_Temperatur_Eiszeit, Karte_Temperatur_Wüste,
                                
                                 -- Neue Kartenressorucen immer vor Überfluss einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 Karte_Ressource_Arm, Karte_Ressource_Wenig, Karte_Ressource_Mittel, Karte_Ressource_Viel, Karte_Ressource_Überfluss,
                                   
                                 -- Neue Schwierigkeitsgrade immer vor Schwer einfügen um Anpassungen weiter unten zu vermeiden.
                                 Schwierigkeitsgrad_Leicht, Schwierigkeitsgrad_Mittel, Schwierigkeitsgrad_Schwer,
                                 
                                 Keine_Rasse, Menschen, Kasrodiah, Lasupin, Lamustra, Manuky, Suroka, Pryolon, Talbidahr, Moru_Phisihl, Larinos_Lotaris, Carupex, Alary, Tesorahn, Natries_Zermanis, Tridatus, Senelari,
                                 Aspari_2, Ekropa
                                );
   pragma Ordered (Rückgabe_Werte_Enum);
   
   subtype Schwierigkeitsgrad_Verwendet_Enum is Rückgabe_Werte_Enum range Schwierigkeitsgrad_Leicht .. Schwierigkeitsgrad_Schwer;
   
   subtype Zurück_Beenden_Enum is Rückgabe_Werte_Enum range Zurück .. Spiel_Beenden;
   subtype Hauptmenü_Beenden_Enum is Zurück_Beenden_Enum range Hauptmenü .. Spiel_Beenden;
   
   type Welches_Menü_Enum is (Haupt_Menü, Spiel_Menü, Optionen_Menü, Kartengröße_Menü, Kartenart_Menü, Kartenform_Menü, Kartentemperatur_Menü, Kartenressourcen_Menü, Schwierigkeitsgrad_Menü, Rassen_Menü,
                               Grafik_Menü, Sound_Menü, Steuerung_Menü, Sonstiges_Menü);
   
   type Anfang_Ende_Enum is (Anfangswert, Endwert);
   for Anfang_Ende_Enum use (Anfangswert => 0, Endwert => 1);
   
   subtype Rassen_Enum is Rückgabe_Werte_Enum range Keine_Rasse .. Ekropa;
   subtype Rassen_Verwendet_Enum is Rassen_Enum range Menschen .. Ekropa;
   
   type Grafik_Aktuelle_Darstellung_Enum is (Grafik_Konsole, Grafik_SFML, Grafik_Intro,
                                             Grafik_Pause, Grafik_Laden,
                                             Grafik_Menüs, Grafik_Sprache,
                                             Grafik_Weltkarte, Grafik_Stadtkarte, Grafik_Forschung, Grafik_Bauen, -- Grafik_Handeln, (in die Menüs schieben? Geht so nicht in die Menüs.)
                                             Grafik_Ende);
   
   subtype Anzeige_Art_Enum is Grafik_Aktuelle_Darstellung_Enum range Grafik_Konsole .. Grafik_SFML;
   
   type Musik_Aktuelle_Auswahl_Enum is (Musik_Konsole, Musik_SFML,
                                       
                                        Musik_Ende);
   
   type Welche_Eingabe_Enum is (Keine_Eingabe, Zahlen_Eingabe, Text_Eingabe, Einheit_Auswahl);
   
   type NotAus is range 1 .. 100;
   subtype NotAusKlein is NotAus range 1 .. 5;
   -- Wichtige Werte



   -- Für Anzeige
   type TextDateien is range 0 .. 31;
   type TextZeilen is range 0 .. 93;
   subtype TextZeilenOhneNull is TextZeilen range 1 .. TextZeilen'Last;
   -- Für Anzeige



   -- Für Tastenbelegung
   type Tastenbelegung_Enum is (Leer,
                                -- Bewegung
                                Oben, Links, Unten, Rechts, Links_Oben, Rechts_Oben, Links_Unten, Rechts_Unten, Ebene_Hoch, Ebene_Runter,
                                Auswählen, Menü_Zurück,
                                Bauen, Forschung, Tech_Baum,
                                Nächste_Stadt, Einheit_Mit_Bewegungspunkte, Alle_Einheiten, Einheiten_Ohne_Bewegungspunkte, Nächste_Stadt_Mit_Meldung, Nächste_Einheit_Mit_Meldung,
                                -- Einheitenbefehle Verbesserungen
                                Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen,
                                -- Einheitenbefehle allgemein
                                Heilen, Verschanzen, Runde_Aussetzen, Plündern, Auflösen, Einheit_Verbessern,
                                Heimatstadt_Ändern,
                                -- Sonstiges
                                Infos, Diplomatie, GeheZu,
                                Stadt_Umbenennen, Stadt_Abreißen, Stadt_Suchen,
                                Runde_Beenden, Cheatmenü);

   subtype Tastenbelegung_Verwendet_Enum is Tastenbelegung_Enum range Oben .. Tastenbelegung_Enum'Last;
   subtype Tastenbelegung_Bewegung_Enum is Tastenbelegung_Verwendet_Enum range Oben .. Ebene_Runter;
   subtype Tastenbelegung_Bewegung_Stadt_Enum is Tastenbelegung_Verwendet_Enum range Oben .. Rechts_Unten;
   subtype Tastenbelegung_Befehle_Enum is Tastenbelegung_Verwendet_Enum range Straße_Bauen .. Einheit_Verbessern;
   subtype Tastenbelegung_Befehle_Anzeige is Tastenbelegung_Befehle_Enum range Straße_Bauen .. Verschanzen;
   subtype Tastenbelegung_Verbesserung_Befehle_Enum is Tastenbelegung_Befehle_Enum range Straße_Bauen .. Roden_Trockenlegen;
   subtype Tastenbelegung_Allgemeine_Befehle_Enum is Tastenbelegung_Befehle_Enum range Heilen .. Tastenbelegung_Befehle_Enum'Last;
   -- Für Tastenbelegung
   
   
   
   -- Sonstiges
   type Spieler_Enum is (Leer, Spieler_Mensch, Spieler_KI);
   pragma Ordered (Spieler_Enum);
   type RassenImSpielArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of Spieler_Enum;

   type Staatsform_Enum is (Anarchie,
                            Demokratie);

   type StaatsformenArray is array (1 .. 5) of Staatsform_Enum;
   -- Sonstiges



   -- Für Diplomatie
   type Status_Untereinander_Enum is (Unbekannt, Neutral, Nichtangriffspakt, Krieg);
   subtype Status_Untereinander_Bekannt_Enum is Status_Untereinander_Enum range Neutral .. Status_Untereinander_Enum'Last;
   -- Für Diplomatie

end SystemDatentypen;
