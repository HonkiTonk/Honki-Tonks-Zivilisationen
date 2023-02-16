package GrafikDatentypen is
   pragma Pure;

   type Grafik_Aktuelle_Darstellung_Enum is (
                                             Grafik_Start_Enum, Grafik_Intro_Enum, Grafik_Abspann_Enum,
                                             Grafik_Pause_Enum,
                                             Grafik_Generierungszeit_Enum, Grafik_KI_Rechenzeit_Enum, Grafik_Rundenende_Enum, Grafik_Speichern_Laden_Enum,
                                             Grafik_Menüs_Enum, Grafik_Sprache_Enum,
                                             Grafik_Editoren_Enum,
                                             Grafik_Weltkarte_Enum, Grafik_Stadtkarte_Enum, Grafik_Forschung_Enum, Grafik_Bauen_Enum, Grafik_Verkaufen_Enum, Grafik_Forschung_Erfolgreich_Enum,
                                             Grafik_Diplomatie_Enum,
                                             Grafik_Ende_Enum
                                            );
   
   subtype Ladezeiten_Enum is Grafik_Aktuelle_Darstellung_Enum range Grafik_Generierungszeit_Enum .. Grafik_Speichern_Laden_Enum;
   
   
   
   type Fenster_Ändern_Enum is (
                                 Keine_Änderung_Enum,
                                 
                                 Bildrate_Ändern_Enum, Fenster_Verändert_Enum, Auflösung_Verändert_Enum, Modus_Verändert_Enum
                                );
   
   subtype Fenster_Wurde_Verändert_Enum is Fenster_Ändern_Enum range Fenster_Verändert_Enum .. Modus_Verändert_Enum;
   
   
   
   -- Oder in eigene Datentypen verschieben? äöü
   type Welche_Eingabe_Enum is (
                                Keine_Eingabe_Enum,
                                
                                Zahlen_Eingabe_Enum, Text_Eingabe_Enum, Zeichen_Eingabe_Enum, Ja_Nein_Enum,
                                
                                Einheit_Auswahl_Enum
                               );
   
   subtype Eingaben_Vorhanden_Enum is Welche_Eingabe_Enum range Welche_Eingabe_Enum'Succ (Welche_Eingabe_Enum'First) .. Welche_Eingabe_Enum'Last;
   subtype Eingaben_Fragen_Enum is Eingaben_Vorhanden_Enum range Zahlen_Eingabe_Enum .. Ja_Nein_Enum;
      
   
   
   type Hintergrund_Enum is (
                             -- Das hier kann später vermutlich wieder weg? äöü
                             Intro_Hintergrund_Enum,
                             
                             Seitenleiste_Hintergrund_Enum, Bauen_Hintergrund_Enum, Forschung_Hintergrund_Enum, Menü_Hintergrund_Enum, PZB_Ende_Hintergrund_Enum,
                             
                             Auswahl_Hintergrund_Enum, Meldung_Hintergrund_Enum
                            );
   
   subtype Hintergrund_Undurchsichtig_Enum is Hintergrund_Enum range Hintergrund_Enum'First .. PZB_Ende_Hintergrund_Enum;
   subtype Hintergrund_Durchsichtig_Enum is Hintergrund_Enum range Auswahl_Hintergrund_Enum .. Hintergrund_Enum'Last;
   
   
   
   -- Bei Änderungen hier muss auch immer die Reihenfolge der 0-Dateien in den Spezieshintergründen angepasst werden!
   type Spezieshintergrund_Enum is (
                                    Leer_Hintergrund_Enum,
                                   
                                    Forschungserfolg_Enum,
                                   
                                    -- Abspann
                                    Gewonnen_Enum,
                                    Verloren_Enum,
                                   
                                    Planet_Vernichtet_Enum
                                   );
   
   subtype Spezieshintergrund_Vorhanden_Enum is Spezieshintergrund_Enum range Spezieshintergrund_Enum'Succ (Spezieshintergrund_Enum'First) .. Spezieshintergrund_Enum'Last;
   
   subtype Abspann_Enum is Spezieshintergrund_Vorhanden_Enum range Gewonnen_Enum .. Spezieshintergrund_Vorhanden_Enum'Last;
   
   
   
   type Systemgrafiken_Enum is (
                                Test_Enum
                               );
   
   -- subtype  is Systemgrafiken_Enum range  .. ;
   
   
   
   type Editor_Enum is (
                        Kartengrund_Editor_Enum, Einheiten_Editor_Enum, Gebäude_Editor_Enum, Forschungen_Editor_Enum
                       );

end GrafikDatentypen;
