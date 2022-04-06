pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package GrafikTonDatentypen is

   -- Grafik
   type Grafik_Aktuelle_Darstellung_Enum is (Grafik_Konsole_Enum, Grafik_SFML_Enum, Grafik_Intro_Enum,
                                             Grafik_Pause_Enum, Grafik_Laden_Enum,
                                             Grafik_Menüs_Enum, Grafik_Sprache_Enum,
                                             Grafik_Editoren_Enum,
                                             Grafik_Weltkarte_Enum, Grafik_Stadtkarte_Enum, Grafik_Forschung_Enum, Grafik_Bauen_Enum,
                                             ---------------------- Grafik_Debug, -- Grafik_Handeln, In die Menüs schieben? Geht so nicht in die Menüs.
                                             Grafik_Ende_Enum);
   
   subtype Anzeige_Art_Enum is Grafik_Aktuelle_Darstellung_Enum range Grafik_Konsole_Enum .. Grafik_SFML_Enum;
   subtype Editoren_Anzeigen_Enum is Grafik_Aktuelle_Darstellung_Enum range Grafik_Editoren_Enum .. Grafik_Editoren_Enum;
   -- Grafik
   
   
   
   -- Musik
   type Musik_Aktuelle_Auswahl_Enum is (Musik_Konsole_Enum, Musik_SFML_Enum, Musik_Intro_Enum,
                                       
                                        Musik_Ende_Enum);
   -- Musik
   
   
   
   -- Sound
   -- Sound in der Konsole drin lassen? Piepsound kann sie ja theoretisch? Als zukünftiges Feature?
   -- Wahrscheinlich einfach nur sinnlos und wird niemals eingebaut werden.
   type Sound_Aktuelle_Auswahl_Enum is (Sound_Konsole_Enum, Sound_SFML_Enum,
                                        
                                        Sound_Ende_Enum);
   -- Sound

end GrafikTonDatentypen;
