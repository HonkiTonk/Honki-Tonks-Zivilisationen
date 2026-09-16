package KartenrohstoffeDatentypen is
   pragma Pure;
   
   -- Pro Kartenfeld mehr als eine Rohstoffe erlauben? äöü
   -- Grobe Aufteilung: Pflanze, Tier, Mineral, Sonstiges
   type Rohstoffe_Enum is (
                           Leer_Rohstoffe_Enum,
                           
                           Weizen_Enum, Mais_Enum, Reis_Enum, Getreide_Enum, Sojabohnen_Enum, Kartoffeln_Enum, Oliven_Enum, Datteln_Enum, Baumwolle_Enum, Kakaobaum_Enum, Bananen_Enum, Trüffel_Enum,
                           Muskatnuss_Enum, Pfefferstrauch_Enum, Zitrusfrüchte_Enum, Hopfen_Enum, Algen_Enum, Nelken_Enum, Tabak_Enum, Weihrauch_Enum, Tee_Enum, Kaffeestrauch_Enum, Seidenraupe_Enum, Holz_Enum,
                           Zuckerrohr_Enum, Zuckerrübe_Enum, Weintrauben_Enum,
                           
                           Fisch_Enum, Wale_Enum, Vögel_Enum, Krabben_Enum, Muscheln_Enum, Rinder_Enum, Rotwild_Enum, Schafe_Enum, Schweine_Enum, Schaben_Enum, Kamele_Enum, Büffel_Enum, Robben_Enum, Elefanten_Enum,
                           Pferde_Enum,
                             
                           Ton_Enum, Sand_Enum, Golderz_Enum, Silbererz_Enum, Zinn_Enum, Blei_Enum, Eisenerz_Enum, Kupfererz_Enum, Öl_Enum, Uranerz_Enum, Gips_Enum, Manganerz_Enum, Silizium_Enum, Cobalt_Enum,
                           Torf_Enum, Jade_Enum, Salpeter_Enum, Marmor_Enum, Quecksilber_Enum, Bernstein_Enum, Lapislazuli_Enum, Schieferöl_Enum, Braunkohle_Enum, Quarz_Enum, Kaolin_Enum, -- (Porzellanerde)
                           Schwarzkohle_Enum, Manganknollen_Enum,
                           
                           Chitin_Enum, Perlen_Enum, Steinsalz_Enum, Meersalz_Enum, Alaune_Enum, Chinin_Enum, Kautschuk_Enum
                               
                           -- Weitere Optionen zum drüber nachdenken: äöü
                           -- Eventuell Standardzeug auf Basis des Basis/Zusatzgrundes einbauen? äöü
                           -- Stein, Tischholz, Tropenholz
                           -- Obst/Gemüse/Tiere/Wildtiere/Nutztiere/Wild/Edelsteine/Gewürze/Faserpflanzen/Hülsenfrüchte als Begriff für alles was ich nicht einzeln aufteile? äöü
                          );
   pragma Ordered (Rohstoffe_Enum);
   
   subtype Rohstoffe_Vorhanden_Enum is Rohstoffe_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Enum'First) .. Rohstoffe_Enum'Last;
   
   -- Diese vier später wieder löschen, sind nur Übergangsweise hier: äöü
   subtype Rohstoffe_Oberfläche_Land_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   subtype Rohstoffe_Oberfläche_Wasser_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   subtype Rohstoffe_Unterfläche_Land_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   subtype Rohstoffe_Unterfläche_Wasser_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   
   
   
   type Rohstoffanzahl_Enum is (
                                Rohstoff_Eins_Enum, Rohstoff_Zwei_Enum, Rohstoff_Drei_Enum, Rohstoffe_Vier_Enum
                               );
   pragma Ordered (Rohstoffanzahl_Enum);
   
   
   
   -- Verarbeitung bei den Rohstoffen lassen oder in eine eigene Datei/zu den Verbesserungen schieben? äöü
   type Verarbeitungsstufe_Eins_Enum is (
                                         Leer_Verarbeitung_Enum,
                                   
                                         Zucker_Enum, Papier_Enum, Glas_Enum, Werkzeuge_Enum, Wein_Enum, Porzellan_Enum, Leder_Enum, Möbel_Enum, Luxusgüter_Enum, Schmuck_Enum,
                                         Arzneimittel_Enum, Waffen_Enum, Schusswaffen_Enum, Artillerie_Enum, Gummi_Enum, Farbstoffe_Enum, Wolle_Enum, Kakao_Enum, Pfeffer_Enum, Bier_Enum, Pelze_Enum, Kaffee_Enum,
                                         Seide_Enum, Holzkohle_Enum, Salz_Enum, Gold_Enum, Silber_Enum, Eisen_Enum, Kupfer_Enum, Benzin_Enum, Uran_Enum, Öl_Enum, Mangan_Enum, Aluminium_Enum, Elfenbein_Enum
                                        );
   pragma Ordered (Verarbeitungsstufe_Eins_Enum);
   
   subtype Verarbeitungsstufe_Eins_Vorhanden_Enum is Verarbeitungsstufe_Eins_Enum range Verarbeitungsstufe_Eins_Enum'Succ (Verarbeitungsstufe_Eins_Enum'First) .. Verarbeitungsstufe_Eins_Enum'Last;
   
   
   
   type Verarbeitungsstufe_Zwei_Enum is (
                                         Leer_Verarbeitung_Enum,
                                         
                                         Stoff_Enum, Bücher_Enum, Werkzeug_Maschinen_Enum
                                        );
   pragma Ordered (Verarbeitungsstufe_Zwei_Enum);
   
   subtype Verarbeitungsstufe_Zwei_Vorhanden_Enum is Verarbeitungsstufe_Zwei_Enum range Verarbeitungsstufe_Zwei_Enum'Succ (Verarbeitungsstufe_Zwei_Enum'First) .. Verarbeitungsstufe_Zwei_Enum'Last;
   
   
   
   type Verarbeitungsstufe_Drei_Enum is (
                                         Leer_Verarbeitung_Enum,
                                         
                                         Kleidung_Enum, CnC_Maschinen_Enum
                                        );
   pragma Ordered (Verarbeitungsstufe_Drei_Enum);
   
   subtype Verarbeitungsstufe_Drei_Vorhanden_Enum is Verarbeitungsstufe_Drei_Enum range Verarbeitungsstufe_Drei_Enum'Succ (Verarbeitungsstufe_Drei_Enum'First) .. Verarbeitungsstufe_Drei_Enum'Last;

end KartenrohstoffeDatentypen;
