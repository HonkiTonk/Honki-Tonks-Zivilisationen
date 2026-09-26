package KartenrohstoffeDatentypen is
   pragma Pure;
   
   -- Grobe Aufteilung: Pflanzen, Tiere, Mineralien,
   -- Oberarten/begriffe als Rohstoffe für alles was ich nicht einzeln aufteile oder erfasse.
   type Rohstoffe_Enum is (
                           Leer_Rohstoffe_Enum,
                           
                           Gemüse_Enum, Obst_Enum, Faserpflanzen_Enum, Kräuter_Enum, Hülsenfrüchte_Enum, Gewürze_Enum, Pilze_Enum, Zitrusfrüchte_Enum,
                           
                           Getreide_Enum, Weizen_Enum, Gerste_Enum, Hirse_Enum, Roggen_Enum,
                           Mais_Enum, Reis_Enum, Sojabohnen_Enum, Kartoffeln_Enum, Oliven_Enum, Datteln_Enum, Bananen_Enum, Hopfen_Enum, Safran_Enum, Tomaten_Enum, Vanille_Enum, Äpfel_Enum, Teebläter_Enum,
                           Muskatnuss_Enum, Pfefferstrauch_Enum, Nelken_Enum, Tabak_Enum, Weihrauch_Enum, Kaffeestrauch_Enum, Algen_Enum, Zimt_Enum, Zuckerrohr_Enum, Zuckerrübe_Enum, Weintrauben_Enum,
                           
                           Holz_Enum, Dschungelholz_Enum, Ebenholz_Enum,
                           Baumwolle_Enum, Kakaobaum_Enum, Trüffel_Enum, Hanf_Enum, Schlafmohn_Enum, Kautschuk_Enum, Chinarinde_Enum,
                           
                           
                           
                           Fische_Enum, Wale_Enum, Krabben_Enum, Krebse_Enum, Muscheln_Enum, Schildkröten_Enum, Meeresfrüchte_Enum,
                           
                           Vögel_Enum, Bienen_Enum,
                           
                           Nutztiere_Enum, Wildtiere_Enum, Seltene_Tiere_Enum,
                           
                           Rinder_Enum, Rotwild_Enum, Schafe_Enum, Schweine_Enum, Schaben_Enum, Kamele_Enum, Büffel_Enum, Elefanten_Enum, Pferde_Enum, Llamas_Enum,
                           Pinguine_Enum, Robben_Enum,
                           Seidenraupe_Enum,
                           
                           
                           
                           -- Kaolin = Porzellanerde
                           -- Galenit = Rohblei
                           Mineralien_Enum, Edelsteine_Enum, Erze_Enum,
                           
                           Golderz_Enum, Silbererz_Enum, Galenit_Enum, Zinnerz_Enum, Eisenerz_Enum, Kupfererz_Enum, Öl_Enum, Uranerz_Enum, Gips_Enum, Manganerz_Enum, Silizium_Enum,
                           Nickelerz_Enum, Jade_Enum, Salpeter_Enum, Zinnober_Enum, Bernstein_Enum, Lapislazuli_Enum, Braunkohle_Enum, Schwarzkohle_Enum, Quarz_Enum, Kaolin_Enum,
                           Zink_Enum, Schwefel_Enum, Bauxit_Enum, Brom_Enum, Steinsalz_Enum, Alaune_Enum,
                           
                           Ton_Enum, Sand_Enum, Torf_Enum, Stein_Enum, Lehm_Enum, Schiefer_Enum, Marmor_Enum,
                           
                           Perlen_Enum, Meersalz_Enum,
                           
                           Manganknollen_Enum
                          );
   pragma Ordered (Rohstoffe_Enum);
   
   subtype Rohstoffe_Vorhanden_Enum is Rohstoffe_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Enum'First) .. Rohstoffe_Enum'Last;
   
   subtype Rohstoffe_Pflanzen_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'First .. Chinarinde_Enum;
   subtype Rohstoffe_Pflanzen_Oberbegriffe_Enum is Rohstoffe_Pflanzen_Enum range Rohstoffe_Pflanzen_Enum'First .. Zitrusfrüchte_Enum;
   subtype Rohstoffe_Pflanzen_Unterbegriffe_Enum is Rohstoffe_Pflanzen_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Pflanzen_Oberbegriffe_Enum'Last) .. Rohstoffe_Pflanzen_Enum'Last;
   subtype Rohstoffe_Pflanzen_Holz_Enum is Rohstoffe_Pflanzen_Unterbegriffe_Enum range Holz_Enum .. Ebenholz_Enum;
   
   subtype Rohstoffe_Tiere_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Pflanzen_Enum'Last) .. Seidenraupe_Enum;
   subtype Rohstoffe_Wassertiere_Enum is Rohstoffe_Tiere_Enum range Rohstoffe_Tiere_Enum'First .. Meeresfrüchte_Enum;
   subtype Rohstoffe_Flugtiere_Enum is Rohstoffe_Tiere_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Wassertiere_Enum'Last) .. Bienen_Enum;
   subtype Rohstoffe_Bodentiere_Enum is Rohstoffe_Tiere_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Flugtiere_Enum'Last) .. Seidenraupe_Enum;
   subtype Rohstoffe_Bodentiere_Oberbegriffe_Enum is Rohstoffe_Bodentiere_Enum range Rohstoffe_Bodentiere_Enum'First .. Seltene_Tiere_Enum;
   subtype Rohstoffe_Insekten_Enum is Rohstoffe_Bodentiere_Enum range Seidenraupe_Enum .. Rohstoffe_Bodentiere_Enum'Last;
   
   subtype Rohstoffe_Mineralien_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Tiere_Enum'Last) .. Rohstoffe_Vorhanden_Enum'Last;
   subtype Rohstoffe_Mineralien_Oberbegriffe_Enum is Rohstoffe_Mineralien_Enum range Rohstoffe_Mineralien_Enum'First .. Erze_Enum;
   subtype Rohstoffe_Mineralien_Unterbegriffe_Enum is Rohstoffe_Mineralien_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Mineralien_Oberbegriffe_Enum'Last) .. Rohstoffe_Mineralien_Enum'Last;
   subtype Rohstoffe_Eis_Enum is Rohstoffe_Mineralien_Unterbegriffe_Enum range Rohstoffe_Mineralien_Unterbegriffe_Enum'First .. Alaune_Enum;
   subtype Rohstoffe_Wassermineralien_Enum is Rohstoffe_Mineralien_Unterbegriffe_Enum range Perlen_Enum .. Rohstoffe_Mineralien_Unterbegriffe_Enum'Last;
   
   -- Diese vier später wieder löschen, sind nur Übergangsweise hier: äöü
   subtype Rohstoffe_Oberfläche_Wasser_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   subtype Rohstoffe_Unterfläche_Land_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   subtype Rohstoffe_Unterfläche_Wasser_Enum is Rohstoffe_Vorhanden_Enum range Rohstoffe_Vorhanden_Enum'Range;
   
   
   
   type Rohstoffanzahl_Enum is (
                                Rohstoff_Eins_Enum, Rohstoff_Zwei_Enum, Rohstoff_Drei_Enum, Rohstoffe_Vier_Enum
                               );
   pragma Ordered (Rohstoffanzahl_Enum);

end KartenrohstoffeDatentypen;
