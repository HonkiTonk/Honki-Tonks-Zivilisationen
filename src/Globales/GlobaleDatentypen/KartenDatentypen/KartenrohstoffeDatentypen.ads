package KartenrohstoffeDatentypen is
   pragma Pure;
   
   -- Grobe Aufteilung: Pflanze, Tier, Mineral, Sonstiges
   -- Oberarten/begriffe als Rohstoffe für alles was ich nicht einzeln aufteile oder erfasse.
   type Rohstoffe_Enum is (
                           Leer_Rohstoffe_Enum,
                           
                           Gemüse_Enum, Obst_Enum, Faserpflanzen_Enum, Kräuter_Enum, Hülsenfrüchte_Enum, Gewürze_Enum, Zitrusfrüchte_Enum,
                           
                           Getreide_Enum, Weizen_Enum, Gerste_Enum, Hirse_Enum, Roggen_Enum,
                           Mais_Enum, Reis_Enum, Sojabohnen_Enum, Kartoffeln_Enum, Oliven_Enum, Datteln_Enum, Bananen_Enum, Hopfen_Enum, Safran_Enum, Tomaten_Enum, Vanille_Enum, Äpfel_Enum, Teebläter_Enum,
                           Muskatnuss_Enum, Pfefferstrauch_Enum, Nelken_Enum, Tabak_Enum, Weihrauch_Enum, Kaffeestrauch_Enum, Algen_Enum, Zimt_Enum, Zuckerrohr_Enum, Zuckerrübe_Enum, Weintrauben_Enum,
                           
                           Baumwolle_Enum, Kakaobaum_Enum, Trüffel_Enum, Hanf_Enum, Schlafmohn_Enum, Holz_Enum, Dschungelholz_Enum, Ebenholz_Enum,
                           
                           Fisch_Enum, Wale_Enum, Krabben_Enum, Muscheln_Enum, Schildkröten_Enum, Meeresfrüchte_Enum,
                           
                           Vögel_Enum, Bienen_Enum,
                           
                           Nutztiere_Enum, Wildtiere_Enum, Seltene_Tiere,
                           
                           Rinder_Enum, Rotwild_Enum, Schafe_Enum, Schweine_Enum, Schaben_Enum, Kamele_Enum, Büffel_Enum, Robben_Enum, Elefanten_Enum, Pferde_Enum, Llamas_Enum, Seidenraupe_Enum,
                           
                           -- Kaolin = Porzellanerde
                           -- Galenit = Rohblei
                           Mineralien_Enum,
                           
                           Ton_Enum, Sand_Enum, Golderz_Enum, Silbererz_Enum, Galenit_Enum, Zinnerz_Enum, Eisenerz_Enum, Kupfererz_Enum, Öl_Enum, Uranerz_Enum, Gips_Enum, Manganerz_Enum, Silizium_Enum,
                           Nickelerz_Enum, Torf_Enum, Jade_Enum, Salpeter_Enum, Marmor_Enum, Zinnober_Enum, Bernstein_Enum, Lapislazuli_Enum, Schiefer_Enum, Braunkohle_Enum, Quarz_Enum, Kaolin_Enum,
                           Schwarzkohle_Enum, Manganknollen_Enum, Zink_Enum, Schwefel_Enum, Lehm_Enum, Bauxit_Enum, Brom_Enum, Edelsteine_Enum, Stein_Enum,
                           
                           Perlen_Enum, Steinsalz_Enum, Meersalz_Enum, Alaune_Enum, Chinin_Enum, Kautschuk_Enum
                               
                          );
   pragma Ordered (Rohstoffe_Enum);
   
   subtype Rohstoffe_Vorhanden_Enum is Rohstoffe_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Enum'First) .. Rohstoffe_Enum'Last;
   
   -- Diese vier später wieder löschen, sind nur Übergangsweise hier: äöü
   subtype Rohstoffe_Oberfläche_Land_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   subtype Rohstoffe_Oberfläche_Wasser_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   subtype Rohstoffe_Unterfläche_Land_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   subtype Rohstoffe_Unterfläche_Wasser_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   
   
   
   -- Später einsortieren/weiter unterteilen: äöü
   -- Munition
   -- Bögen, Armbrüste, Waffen
   
   type Rohstoffanzahl_Enum is (
                                Rohstoff_Eins_Enum, Rohstoff_Zwei_Enum, Rohstoff_Drei_Enum, Rohstoffe_Vier_Enum
                               );
   pragma Ordered (Rohstoffanzahl_Enum);
   
   
   
   -- Verarbeitung in eine eigene Datei oder zu den Verbesserungen schieben? äöü
   type Verarbeitungsstufe_Eins_Enum is (
                                         Leer_Verarbeitung_Enum,
                                   
                                         Zucker_Enum, Papier_Enum, Glas_Enum, Werkzeuge_Enum, Wein_Enum, Porzellan_Enum, Leder_Enum, Möbel_Enum, Luxusgüter_Enum, Schmuck_Enum,
                                         Arzneimittel_Enum, Waffen_Enum, Schusswaffen_Enum, Artillerie_Enum, Gummi_Enum, Farbstoffe_Enum, Wolle_Enum, Kakao_Enum, Pfeffer_Enum, Bier_Enum, Pelze_Enum, Kaffee_Enum,
                                         Seide_Enum, Holzkohle_Enum, Salz_Enum, Gold_Enum, Silber_Enum, Eisen_Enum, Kupfer_Enum, Benzin_Enum, Uran_Enum, Öl_Enum, Mangan_Enum, Aluminium_Enum, Elfenbein_Enum,
                                         Honig_Enum, Opium_Enum, Inhalationsprodukte_Enum, Keramik_Enum, Milch_Enum, Olivenöl_Enum, Spirituosen_Enum, Teer_Enum, Wachs_Enum, Seltene_Pelze_Enum, Seltenes_Leder_Enum,
                                         Schießpulver_Enum, Bauholz_Enum, Ahornsirup_Enum, Palmöl_Enum, Rum_Enum, Ziegel_Enum, Mehl_Enum, Most_Enum, Messing_Enum, Fässer_Enum, Walfett_Enum, Lampenöl_Enum,
                                         Nahrung_Enum, Kaviar_Enum, Chitin_Enum, Tee_Enum, Zinn_Enum, Kobalt_Enum, Blei_Enum, Quecksilber_Enum, Schieferöl_Enum
                                        );
   pragma Ordered (Verarbeitungsstufe_Eins_Enum);
   
   subtype Verarbeitungsstufe_Eins_Vorhanden_Enum is Verarbeitungsstufe_Eins_Enum range Verarbeitungsstufe_Eins_Enum'Succ (Verarbeitungsstufe_Eins_Enum'First) .. Verarbeitungsstufe_Eins_Enum'Last;
   
   
   
   type Verarbeitungsstufe_Zwei_Enum is (
                                         Leer_Verarbeitung_Enum,
                                         
                                         Stoff_Enum, Bücher_Enum, Werkzeug_Maschinen_Enum, Käse_Enum, Teppiche_Enum, Tuch_Enum, Eis_Enum, Brot_Enum, Seile_Enum, Kerzen_Enum
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
