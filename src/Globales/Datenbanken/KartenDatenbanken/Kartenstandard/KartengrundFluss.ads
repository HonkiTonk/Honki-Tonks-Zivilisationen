with SpeziesDatentypen;
with KartendatenbankRecord;
with BewertungDatentypen;
with KartenextraDatentypen;

package KartengrundFluss is
   pragma Pure;
   
   type KartenflusslisteOberflächeArray is array (KartenextraDatentypen.Fluss_Oberfläche_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenflusslisteOberfläche : constant KartenflusslisteOberflächeArray := (
                                                                               others =>
                                                                                 (
                                                                                  Bewertung =>
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
   
   type KartenflusslisteUnterflächeArray is array (KartenextraDatentypen.Fluss_Unterfläche_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenflusslisteUnterfläche : constant KartenflusslisteUnterflächeArray := (
                                                                                 others =>
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
   
   type KartenflusslisteKernArray is array (KartenextraDatentypen.Fluss_Kernfläche_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenflusslisteKern : constant KartenflusslisteKernArray := (
                                                                 others =>
                                                                   (
                                                                    Bewertung =>
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

end KartengrundFluss;
