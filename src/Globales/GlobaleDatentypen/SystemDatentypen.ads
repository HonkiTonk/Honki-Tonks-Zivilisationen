pragma SPARK_Mode (On);

package SystemDatentypen is

   -- Sonstiges
   type Rückgabe_Werte_Enum is (Leer, Start_Weiter, Hauptmenü, Spiel_Beenden, Zurück, Ja, Nein, Speichern, Laden, Optionen, Informationen, Wiederherstellen, Würdigungen, Runde_Beenden, Sieg, Vernichtung,
                                 
                                 Auswahl_Kartengröße, Auswahl_Kartenart, Auswahl_Kartenform, Auswahl_Kartentemperatur, Auswahl_Spieleranzahl, Auswahl_Belegung, Auswahl_Schwierigkeitsgrad, Auswahl_Kartenressourcen,
                                 
                                 Karte_20_20, Karte_40_40, Karte_80_80, Karte_120_80, Karte_120_160, Karte_160_160, Karte_240_240, Karte_320_320, Karte_1000_1000, Karte_Nutzer, Karte_Zufall,
                                
                                 -- Neue Kartenarten immer vor Chaos einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 Art_Inseln, Art_Kontinente, Art_Pangäa, Art_Nur_Land, Art_Chaos, Art_Zufall
                                
                                
                                
                                
                                
                                
                                
                                
                                );
   pragma Ordered (Rückgabe_Werte_Enum);
   
   type Welches_Menü_Enum is (Haupt_Menü, Spiel_Menü, Optionen_Menü, Kartengröße_Menü, Kartenart_Menü);
   
   type Anfang_Ende_Enum is (Anfangswert, Endwert);
   for Anfang_Ende_Enum use (Anfangswert => 0, Endwert => 1);

   type Schwierigkeitsgrad_Enum is (Leer, Einfach, Mittel, Schwer);
   for Schwierigkeitsgrad_Enum use (Leer => 0, Einfach => 1, Mittel => 2, Schwer => 3);
   pragma Ordered (Schwierigkeitsgrad_Enum);
   subtype Schwierigkeitsgrad_Verwendet_Enum is Schwierigkeitsgrad_Enum range Einfach .. Schwierigkeitsgrad_Enum'Last;
   
   type Anzeige_Art_Enum is (Konsole, SFML, Beides);
   subtype Anzeige_Art_Grafik_Enum is Anzeige_Art_Enum range SFML .. Beides;
   
   type NotAus is range 1 .. 100;
   subtype NotAusKlein is NotAus range 1 .. 5;
   -- Sonstiges



   -- Für Anzeige
   type TextDateien is range 0 .. 31;
   type TextZeilen is range 0 .. 93;
   subtype TextZeilenOhneNull is TextZeilen range 1 .. TextZeilen'Last;
   -- Für Anzeige



   -- Für Tastenbelegung
   type Tastenbelegung_Enum is (Leer, Mausbewegung,
                                -- Bewegung
                                Oben, Links, Unten, Rechts, Links_Oben, Rechts_Oben, Links_Unten, Rechts_Unten, Ebene_Hoch, Ebene_Runter,
                                Auswählen, Menü_Zurück,
                                Bauen, Forschung, Tech_Baum,
                                Nächste_Stadt, Einheit_Mit_Bewegungspunkte, Alle_Einheiten, Einheiten_Ohne_Bewegungspunkte, Nächste_Stadt_Mit_Meldung, Nächste_Einheit_Mit_Meldung,
                                -- Einheitenbefehle Verbesserungen
                                Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen,
                                -- Einheitenbefehle allgemein
                                Heilen, Verschanzen, Runde_Aussetzen, Plündern, Einheit_Auflösen, Einheit_Verbessern,
                                Heimatstadt_Ändern,
                                -- Sonstiges
                                Infos, Diplomatie, GeheZu,
                                Stadt_Umbenennen, Stadt_Abreißen, Stadt_Suchen,
                                Runde_Beenden, Cheatmenü);

   subtype Tastenbelegung_Verwendet_Enum is Tastenbelegung_Enum range Oben .. Tastenbelegung_Enum'Last;
   subtype Tastenbelegung_Bewegung_Enum is Tastenbelegung_Verwendet_Enum range Oben .. Ebene_Runter;
   subtype Tastenbelegung_Bewegung_Stadt_Enum is Tastenbelegung_Verwendet_Enum range Oben .. Rechts_Unten;
   subtype Tastenbelegung_Befehle_Enum is Tastenbelegung_Verwendet_Enum range Straße_Bauen .. Einheit_Verbessern;
   subtype Tastenbelegung_Verbesserung_Befehle_Enum is Tastenbelegung_Befehle_Enum range Straße_Bauen .. Roden_Trockenlegen;
   subtype Tastenbelegung_Allgemeine_Befehle_Enum is Tastenbelegung_Befehle_Enum range Heilen .. Tastenbelegung_Befehle_Enum'Last;
   -- Für Tastenbelegung

end SystemDatentypen;
