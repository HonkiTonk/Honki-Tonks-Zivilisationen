pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package GrafikDatentypen is

   type Grafik_Aktuelle_Darstellung_Enum is (
                                             Grafik_Terminal_Enum, Grafik_SFML_Enum, Grafik_Intro_Enum,
                                             Grafik_Pause_Enum,
                                             Grafik_Generierungszeit_Enum, Grafik_Laden_Enum,
                                             Grafik_Menüs_Enum, Grafik_Sprache_Enum,
                                             Grafik_Editoren_Enum,
                                             Grafik_Weltkarte_Enum, Grafik_Stadtkarte_Enum, Grafik_Forschung_Enum, Grafik_Bauen_Enum,
                                             ---------------------- Grafik_Handeln, In die Menüs schieben?
                                             Grafik_Ende_Enum
                                            );
   
   subtype Anzeige_Art_Enum is Grafik_Aktuelle_Darstellung_Enum range Grafik_Terminal_Enum .. Grafik_SFML_Enum;
   subtype Editoren_Anzeigen_Enum is Grafik_Aktuelle_Darstellung_Enum range Grafik_Editoren_Enum .. Grafik_Editoren_Enum;

end GrafikDatentypen;
