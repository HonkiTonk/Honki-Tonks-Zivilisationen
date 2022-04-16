pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package RueckgabeDatentypen is

   --------------------- Weitere Auteilungen vornehmen, wie bei den RassenDatentypen.
   type Rückgabe_Werte_Enum is (
                                 -- Allgemeines
                                 Start_Weiter_Enum, Zurück_Enum, Hauptmenü_Enum, Spiel_Beenden_Enum, Ja_Enum, Nein_Enum, Speichern_Enum, Laden_Enum, Optionen_Enum, Wiederherstellen_Enum,
                                 Würdigungen_Enum, Runde_Beenden_Enum, Sieg_Enum, Vernichtung_Enum, Zufall_Enum, Eingabe_Enum, Grafik_Enum, Sound_Enum, Steuerung_Enum, Sonstiges_Enum, Fertig_Enum, Schleife_Verlassen_Enum,
                                 Anzahl_Speicherstände_Enum, Runden_Bis_Autospeichern_Enum, Sprache_Enum, Spielmenü_Enum,
                                 
                                 -- Grafikmenü
                                 Auflösung_Ändern_Enum, Vollbild_Fenster_Enum, Bildrate_Ändern_Enum, Schriftgröße_Enum,
                                 
                                 -- Soundmenü
                                 
                                 
                                 -- Editoren
                                 Editoren_Enum, Kartenfeld_Editor_Enum, Einheiten_Editor_Enum, Gebäude_Editor_Enum, Forschung_Editor_Enum, Verbesserungen_Editor_Enum,
                                                                  
                                 -- Karteneinstellungen
                                 Auswahl_Kartengröße_Enum, Auswahl_Kartenart_Enum, Auswahl_Kartenform_Enum, Auswahl_Kartentemperatur_Enum, Auswahl_Rassen_Enum, Auswahl_Schwierigkeitsgrad_Enum,
                                 Auswahl_Kartenressourcen_Enum,
                                 
                                 -- Neue Kartengrößen immer zwischen 20 und 1.000 einfügen um Anpassungen in KartenDatentypen zu vermeiden, außer die minimale oder maximale Kartengröße soll verändert werden.
                                 Kartengröße_20_20_Enum, Kartengröße_40_40_Enum, Kartengröße_80_80_Enum, Kartengröße_120_80_Enum, Kartengröße_120_160_Enum, Kartengröße_160_160_Enum, Kartengröße_240_240_Enum,
                                 Kartengröße_320_320_Enum, Kartengröße_1000_1000_Enum, Kartengröße_Nutzer_Enum, Kartengröße_Zufall_Enum,
                                
                                 -- Neue Kartenarten immer vor Chaos einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 Kartenart_Inseln_Enum, Kartenart_Kontinente_Enum, Kartenart_Pangäa_Enum, Kartenart_Nur_Land_Enum, Kartenart_Chaos_Enum,
                                
                                 -- Neue Kartenformen immer vor Tugel Extrem einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 Karte_Form_X_Zylinder_Enum, Karte_Form_Y_Zylinder_Enum, Karte_Form_Torus_Enum, Karte_Form_Kugel_Enum, Karte_Form_Viereck_Enum, Karte_Form_Kugel_Gedreht_Enum, Karte_Form_Tugel_Enum,
                                 Karte_Form_Tugel_Gedreht_Enum, Karte_Form_Tugel_Extrem_Enum,
                                 
                                 -- Immer eventuelle Anpassungen in den KartenDatentypen berücksichtigen.
                                 Karte_E_Achse_Kein_Übergang_Enum, Karte_E_Achse_Übergang_Enum,
                                 Karte_Y_Achse_Kein_Übergang_Enum, Karte_Y_Achse_Übergang_Enum, Karte_Y_Achse_Rückwärts_Verschobener_Übergang_Enum, Karte_Y_Achse_Verschobener_Übergang_Enum,
                                 Karte_X_Achse_Kein_Übergang_Enum, Karte_X_Achse_Übergang_Enum, Karte_X_Achse_Rückwärts_Verschobener_Übergang_Enum, Karte_X_Achse_Verschobener_Übergang_Enum,      
                                 
                                 -- Neue Kartentemperaturen immer vor Wüste einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 Kartentemperatur_Kalt_Enum, Kartentemperatur_Gemäßigt_Enum, Kartentemperatur_Heiß_Enum, Kartentemperatur_Eiszeit_Enum, Kartentemperatur_Wüste_Enum,
                                
                                 -- Neue Kartenressorucen immer vor Überfluss einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 Kartenressourcen_Arm_Enum, Kartenressourcen_Wenig_Enum, Kartenressourcen_Mittel_Enum, Kartenressourcen_Viel_Enum, Kartenressourcen_Überfluss_Enum,
                                 
                                 -- Neue Kartenpole immer vor Karten_Pole_Beide einfügen um Anpassungen in KartenDatentypen zu vermeiden.
                                 ------------------------- Pole auch nur auf einer Seite ermöglichen?
                                 Karten_Pole_Keine, Karten_Pole_YAchse, Karten_Pole_XAchse, Karten_Pole_Beide,
                                   
                                 -- Neue Schwierigkeitsgrade immer vor Schwer einfügen um Anpassungen weiter unten zu vermeiden. Außer wenn es schwerer als schwer werden soll, dann aber auch unten ändern.
                                 Schwierigkeit_Leicht_Enum, Schwierigkeit_Mittel_Enum, Schwierigkeit_Schwer_Enum,
                                 
                                 Keine_Rasse_Enum, Menschen_Enum, Kasrodiah_Enum, Lasupin_Enum, Lamustra_Enum, Manuky_Enum, Suroka_Enum, Pryolon_Enum, Talbidahr_Enum, Moru_Phisihl_Enum, Larinos_Lotaris_Enum, Carupex_Enum,
                                 Alary_Enum, Tesorahn_Enum, Natries_Zermanis_Enum, Tridatus_Enum, Senelari_Enum, Aspari_2_Enum, Ekropa_Enum
                                );
   -- Ordered müsste am Schluss entfernbar sein.
   pragma Ordered (Rückgabe_Werte_Enum);
   
   subtype Kartengröße_Verwendet_Enum is Rückgabe_Werte_Enum range Kartengröße_20_20_Enum .. Kartengröße_Nutzer_Enum;
   subtype Kartengröße_Standard_Enum is Kartengröße_Verwendet_Enum range Kartengröße_20_20_Enum .. Kartengröße_1000_1000_Enum;
   
   subtype Kartenart_Enum is Rückgabe_Werte_Enum range Kartenart_Inseln_Enum .. Kartenart_Chaos_Enum;
   
   subtype Schwierigkeitsgrad_Verwendet_Enum is Rückgabe_Werte_Enum range Schwierigkeit_Leicht_Enum .. Schwierigkeit_Schwer_Enum;
   
   subtype Zurück_Beenden_Enum is Rückgabe_Werte_Enum range Zurück_Enum .. Spiel_Beenden_Enum;
   subtype Hauptmenü_Beenden_Enum is Zurück_Beenden_Enum range Hauptmenü_Enum .. Spiel_Beenden_Enum;
   
   subtype Rassen_Enum is Rückgabe_Werte_Enum range Keine_Rasse_Enum .. Ekropa_Enum;
   subtype Rassen_Verwendet_Enum is Rassen_Enum range Menschen_Enum .. Ekropa_Enum;

end RueckgabeDatentypen;
