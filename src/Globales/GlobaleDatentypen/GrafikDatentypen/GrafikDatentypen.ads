package GrafikDatentypen is
   pragma Pure;

   type Aktuelle_Anzeige_Enum is (
                                  Start_Enum, Intro_Enum, Abspann_Enum,
                                  Pause_Enum,
                                  Generierungszeit_Enum, KI_Rechenzeit_Enum, Rundenende_Enum, Speichern_Laden_Enum,
                                  Menüs_Enum, Sprache_Enum,
                                  Editoren_Enum,
                                  Weltkarte_Enum, Stadtumgebung_Enum, Stadtkarte_Enum,
                                  Forschung_Enum, Forschungserfolg_Enum,
                                  Bauen_Enum, Verkaufen_Enum,
                                  Diplomatie_Enum,
                                  Ende_Enum
                                 );
   
   subtype Ladezeiten_Enum is Aktuelle_Anzeige_Enum range Generierungszeit_Enum .. Speichern_Laden_Enum;
   subtype Stadt_Enum is Aktuelle_Anzeige_Enum range Stadtumgebung_Enum .. Stadtkarte_Enum;
   
   
   
   type Fenster_Anpassen_Enum is (
                                  Keine_Änderung_Enum,
                                 
                                  Bildrate_Ändern_Enum, Fenster_Verändert_Enum, Auflösung_Verändert_Enum, Modus_Verändert_Enum
                                 );
   
   subtype Fenster_Wurde_Verändert_Enum is Fenster_Anpassen_Enum range Fenster_Verändert_Enum .. Modus_Verändert_Enum;
   
   
   
   type Eingabe_Enum is (
                         Keine_Eingabe_Enum,
                                
                         Zahlen_Eingabe_Enum, Text_Eingabe_Enum, Zeichen_Eingabe_Enum, Ja_Nein_Enum,
                                
                         Einheit_Auswahl_Enum
                        );
   
   subtype Eingabe_Vorhanden_Enum is Eingabe_Enum range Eingabe_Enum'Succ (Eingabe_Enum'First) .. Eingabe_Enum'Last;
   subtype Eingabe_Fragen_Enum is Eingabe_Vorhanden_Enum range Zahlen_Eingabe_Enum .. Ja_Nein_Enum;
      
   
   
   type Hintergrund_Enum is (
                             Intro_Hintergrund_Enum, Kartenformen_Enum,
                             
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
   
   subtype Abspannhintergrund_Enum is Spezieshintergrund_Vorhanden_Enum range Gewonnen_Enum .. Spezieshintergrund_Vorhanden_Enum'Last;
   
   
   
   type Systemgrafiken_Enum is (
                                Test_Enum
                               );
   
   -- subtype  is Systemgrafiken_Enum range  .. ;
   
   
   
   type Editor_Enum is (
                        Kartengrund_Editor_Enum, Einheiten_Editor_Enum, Gebäude_Editor_Enum, Forschungen_Editor_Enum
                       );

end GrafikDatentypen;
