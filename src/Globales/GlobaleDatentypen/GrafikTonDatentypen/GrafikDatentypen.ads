pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package GrafikDatentypen is

   type Grafik_Aktuelle_Darstellung_Enum is (
                                             Grafik_Start_Enum, Grafik_Intro_Enum,
                                             Grafik_Pause_Enum,
                                             Grafik_Generierungszeit_Enum, Grafik_KI_Rechenzeit_Enum, Grafik_Rundenende_Enum, Grafik_Speichern_Laden_Enum,
                                             Grafik_Menüs_Enum, Grafik_Sprache_Enum,
                                             Grafik_Editoren_Enum,
                                             Grafik_Weltkarte_Enum, Grafik_Stadtkarte_Enum, Grafik_Forschung_Enum, Grafik_Bauen_Enum, Grafik_Forschung_Efolgreich_Enum,
                                             Grafik_Diplomatie_Enum,
                                             Grafik_Ende_Enum
                                            );
   
   subtype Ladezeiten_Enum is Grafik_Aktuelle_Darstellung_Enum range Grafik_Generierungszeit_Enum .. Grafik_Speichern_Laden_Enum;
   subtype Editoren_Anzeigen_Enum is Grafik_Aktuelle_Darstellung_Enum range Grafik_Editoren_Enum .. Grafik_Editoren_Enum;
   
   
   
   type Fenster_Ändern_Enum is (
                                 Keine_Änderung_Enum,
                                 
                                 Bildrate_Ändern_Enum, Fenster_Verändert_Enum, Auflösung_Verändert_Enum, Modus_Verändert_Enum
                                );
   
   subtype Fenster_Wurde_Verändert_Enum is Fenster_Ändern_Enum range Fenster_Verändert_Enum .. Modus_Verändert_Enum;
   
   
   
   type Hintergrund_Enum is (
                             Seitenleiste_Hintergrund_Enum, Bauen_Hintergrund_Enum, Forschung_Hintergrund_Enum, Menü_Hintergrund_Enum,
                             
                             Auswahl_Hintergrund_Enum, Meldung_Hintergrund_Enum
                            );
   
   subtype Hintergrund_Undurchsichtig_Enum is Hintergrund_Enum range Hintergrund_Enum'First .. Menü_Hintergrund_Enum;
   subtype Hintergrund_Durchsichtig_Enum is Hintergrund_Enum range Auswahl_Hintergrund_Enum .. Hintergrund_Enum'Last;

end GrafikDatentypen;
