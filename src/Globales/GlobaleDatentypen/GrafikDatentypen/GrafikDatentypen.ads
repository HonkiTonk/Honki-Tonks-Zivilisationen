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
                             Kartenformen_Enum,
                             
                             PZB_Ende_Hintergrund_Enum,
                             
                             Auswahl_Hintergrund_Enum, Meldung_Hintergrund_Enum
                            );
   
   subtype Hintergrund_Undurchsichtig_Enum is Hintergrund_Enum range Hintergrund_Enum'First .. PZB_Ende_Hintergrund_Enum;
   subtype Hintergrund_Durchsichtig_Enum is Hintergrund_Enum range Auswahl_Hintergrund_Enum .. Meldung_Hintergrund_Enum;
   
   -- Die Hintergründe alle mal neu aufteilen und so mehr spezienspezifische Hintergründe erlauben oder geht das auch über gut ausgewählte Arrays? äöü
   type Hintergrund_Gesamt_Enum is (
                                    Intro_Eins_Enum,
                                    
                                    Kartenformen_Eins_Enum, Kartenformen_Zwei_Enum, Kartenformen_Drei_Enum, Kartenformen_Vier_Enum,
                                    Kartenformen_Fünf_Enum, Kartenformen_Sechs_Enum, Kartenformen_Sieben_Enum, Kartenformen_Acht_Enum,
                                    Kartenformen_Neun_Enum, Kartenformen_Zehn_Enum, Kartenformen_Elf_Enum, Kartenformen_Zwölf_Enum,
                                    Kartenformen_Dreizehn_Enum, Kartenformen_Vierzehn_Enum, Kartenformen_Fünfzehn_Enum, Kartenformen_Sechzehn_Enum,
                                    Kartenformen_Siebzehn_Enum, Kartenformen_Achtzehn_Enum, Kartenformen_Neunzehn_Enum, Kartenformen_Zwanzig_Enum,
                                    
                                    Menü_Hintergrund_Enum, Bauen_Hintergrund_Enum, Forschung_Hintergrund_Enum,
                                    
                                    Seitenleiste_Hintergrund_Enum
                                   );
   
   subtype Hintergrund_Intro_Enum is Hintergrund_Gesamt_Enum range Hintergrund_Gesamt_Enum'First .. Intro_Eins_Enum;
   subtype Hintergrund_Kartenformen_Enum is Hintergrund_Gesamt_Enum range Kartenformen_Eins_Enum .. Kartenformen_Zwanzig_Enum;
   subtype Hintergrund_Allgemein_Enum is Hintergrund_Gesamt_Enum range Menü_Hintergrund_Enum .. Seitenleiste_Hintergrund_Enum;
   -- Hintergrund_Intro_Enum'Succ (Hintergrund_Intro_Enum'Last).. Seitenleiste_Hintergrund_Enum;
   
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
   
      
      
   type Editor_Enum is (
                        Kartengrund_Editor_Enum, Einheiten_Editor_Enum, Gebäude_Editor_Enum, Forschungen_Editor_Enum
                       );

end GrafikDatentypen;
