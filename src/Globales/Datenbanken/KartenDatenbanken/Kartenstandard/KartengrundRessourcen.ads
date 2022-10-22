pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with RassenDatentypen;
with KartendatenbankRecord;

with KIBewertungDatentypen;

-- Das hier später auch in verschiedene Dateien aufteilen, vorher aber mehr Ressourcen hinzufügen und in bessere Bereiche einteilen. äöü
package KartengrundRessourcen is
   
   type KartenressourcenlisteLandArray is array (KartengrundDatentypen.Kartenressourcen_Oberfläche_Land_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenressourcenlisteLand : constant KartenressourcenlisteLandArray := (
                                                                           KartengrundDatentypen.Kohle_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Null_Enum,
                                                                                 RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Null_Enum,
                                                                                 RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Eins_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Eisen_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Sieben_Enum,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Acht_Enum,
                                                                                 RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Null_Enum,
                                                                                 RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Null_Enum,
                                                                                 RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Drei_Enum,
                                                                                 RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Öl_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                                                           
                                                                           KartengrundDatentypen.Hochwertiger_Boden_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Gold_Enum =>
                                                                             (
                                                                              Bewertung  =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                 RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             )
                                                                          );

   type KartenressourcenlisteWasserArray is array (KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenressourcenlisteWasser : constant KartenressourcenlisteWasserArray := (
                                                                               KartengrundDatentypen.Fisch_Enum =>
                                                                                 (
                                                                                  Bewertung  =>
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum
                                                                                    ),
                                                                              
                                                                                    -- Nahrung, Produktion, Geld, Forschung
                                                                                  Wirtschaft =>
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                    ),
                                                                              
                                                                                    -- Verteidigung, Angriff
                                                                                  Kampf =>
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                     RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                     RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                     RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                     RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                     RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                     RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                     RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                     RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                     RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                     RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                     RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                     RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                     RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                     RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                    )
                                                                                 ),
      
                                                                               KartengrundDatentypen.Wal_Enum =>
                                                                                 (
                                                                                  Bewertung  =>
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum
                                                                                    ),
                                                                              
                                                                                    -- Nahrung, Produktion, Geld, Forschung
                                                                                  Wirtschaft =>
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                     RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                    ),
                                                                              
                                                                                    -- Verteidigung, Angriff
                                                                                  Kampf =>
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                     RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                     RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                     RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                     RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                     RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                     RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                     RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                     RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                     RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                     RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                     RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                     RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                     RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                     RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                    )
                                                                                 )
                                                                              );

end KartengrundRessourcen;
