with SpeziesDatentypen;
with KartendatenbankRecord;
with BewertungDatentypen;
with KartenextraDatentypen;

-- Das hier später auch in verschiedene Dateien aufteilen, vorher aber mehr Ressourcen hinzufügen und in bessere Bereiche einteilen. äöü
package KartengrundRessourcen is
   pragma Pure;
   
   type KartenressourcenlisteLandArray is array (KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenressourcenlisteLand : constant KartenressourcenlisteLandArray := (
                                                                           KartenextraDatentypen.Kohle_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 SpeziesDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Eins_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Alary_Enum            => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (5, 5, 5, 5)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Alary_Enum            => (1, 1),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartenextraDatentypen.Eisen_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 SpeziesDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 SpeziesDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Acht_Enum,
                                                                                 SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                 SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Alary_Enum            => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (5, 5, 5, 5)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Alary_Enum            => (1, 1),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartenextraDatentypen.Öl_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Alary_Enum            => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (5, 5, 5, 5)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Alary_Enum            => (1, 1),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                                                           
                                                                           KartenextraDatentypen.Hochwertiger_Boden_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Alary_Enum            => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (5, 5, 5, 5)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Alary_Enum            => (1, 1),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                                                           
                                                                           KartenextraDatentypen.Hochwertiges_Holz_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Alary_Enum            => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (5, 5, 5, 5)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Alary_Enum            => (1, 1),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartenextraDatentypen.Gold_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Alary_Enum            => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (5, 5, 5, 5),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (5, 5, 5, 5)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 SpeziesDatentypen.Menschen_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 SpeziesDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Manuky_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Suroka_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 SpeziesDatentypen.Carupex_Enum          => (1, 1),
                                                                                 SpeziesDatentypen.Alary_Enum            => (1, 1),
                                                                                 SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 SpeziesDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Senelari_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 SpeziesDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 SpeziesDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             )
                                                                          );

   type KartenressourcenlisteWasserArray is array (KartenextraDatentypen.Ressourcen_Oberfläche_Wasser_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenressourcenlisteWasser : constant KartenressourcenlisteWasserArray := (
                                                                               KartenextraDatentypen.Fisch_Enum =>
                                                                                 (
                                                                                  Bewertung  =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
                                                                                    ),
                                                                              
                                                                                    -- Nahrung, Produktion, Geld, Forschung
                                                                                  Wirtschaft =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Alary_Enum            => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (5, 5, 5, 5)
                                                                                    ),
                                                                              
                                                                                    -- Verteidigung, Angriff
                                                                                  Kampf =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (1, 1),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (1, 1),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (1, 1),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (1, 1),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (1, 1),
                                                                                     SpeziesDatentypen.Alary_Enum            => (1, 1),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (1, 1),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                    )
                                                                                 ),
      
                                                                               KartenextraDatentypen.Wal_Enum =>
                                                                                 (
                                                                                  Bewertung  =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
                                                                                    ),
                                                                              
                                                                                    -- Nahrung, Produktion, Geld, Forschung
                                                                                  Wirtschaft =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Alary_Enum            => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (5, 5, 5, 5),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (5, 5, 5, 5)
                                                                                    ),
                                                                              
                                                                                    -- Verteidigung, Angriff
                                                                                  Kampf =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (1, 1),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (1, 1),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (1, 1),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (1, 1),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (1, 1),
                                                                                     SpeziesDatentypen.Alary_Enum            => (1, 1),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (1, 1),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                    )
                                                                                 )
                                                                              );

end KartengrundRessourcen;
