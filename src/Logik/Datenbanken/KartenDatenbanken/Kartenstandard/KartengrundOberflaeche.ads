pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with EinheitenDatentypen;
with RassenDatentypen;

with DatenbankRecords;

package KartengrundOberflaeche is
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type KartengrundlisteOberflächeArray is array (KartengrundDatentypen.Kartengrund_Oberfläche_Enum'Range) of DatenbankRecords.KartengrundlisteRecord;
   KartengrundlisteOberfläche : constant KartengrundlisteOberflächeArray := (
                                                                               KartengrundDatentypen.Eis_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 0,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 0,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 0,
                                                                                     RassenDatentypen.Suroka_Enum           => 0,
                                                                                     RassenDatentypen.Pryolon_Enum          => 0,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 0,
                                                                                     RassenDatentypen.Alary_Enum            => 0,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 0,
                                                                                     RassenDatentypen.Senelari_Enum         => 0,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 0,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 0,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 0
                                                                                    ),
                                                                       
                                                                                    -- Nahrung, Produktion, Geld, Forschung
                                                                                  Wirtschaft => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Kasrodiah_Enum        => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Lasupin_Enum          => (1, 0, 0, 3),
                                                                                     RassenDatentypen.Lamustra_Enum         => (1, 0, 0, 3),
                                                                                     RassenDatentypen.Manuky_Enum           => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Suroka_Enum           => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Pryolon_Enum          => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => (1, 0, 0, 3),
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => (1, 0, 0, 3),
                                                                                     RassenDatentypen.Carupex_Enum          => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Alary_Enum            => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => (1, 0, 0, 3),
                                                                                     RassenDatentypen.Tridatus_Enum         => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Senelari_Enum         => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Aspari_2_Enum         => (1, 1, 0, 1),
                                                                                     RassenDatentypen.Ekropa_Enum           => (0, 0, 0, 3),
                                                                                     RassenDatentypen.Tesorahn_Enum         => (0, 0, 0, 5),
                                                                                     RassenDatentypen.Talbidahr_Enum        => (0, 0, 0, 3)
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
     
                                                                               KartengrundDatentypen.Wasser_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Wasser_Enum   => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 0,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 0,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 0,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 0,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 0
                                                                                    ),
                                                                       
                                                                                    -- Nahrung, Produktion, Geld, Forschung
                                                                                  Wirtschaft => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => (2, 0, 1, 2),
                                                                                     RassenDatentypen.Kasrodiah_Enum        => (2, 0, 1, 2),
                                                                                     RassenDatentypen.Lasupin_Enum          => (2, 0, 1, 2),
                                                                                     RassenDatentypen.Lamustra_Enum         => (2, 0, 1, 2),
                                                                                     RassenDatentypen.Manuky_Enum           => (1, 0, 1, 2),
                                                                                     RassenDatentypen.Suroka_Enum           => (2, 0, 1, 2),
                                                                                     RassenDatentypen.Pryolon_Enum          => (1, 0, 1, 2),
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => (2, 0, 1, 2),
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => (2, 0, 1, 2),
                                                                                     RassenDatentypen.Carupex_Enum          => (0, 0, 1, 3),
                                                                                     RassenDatentypen.Alary_Enum            => (1, 0, 1, 2),
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => (0, 0, 1, 3),
                                                                                     RassenDatentypen.Tridatus_Enum         => (2, 0, 1, 3),
                                                                                     RassenDatentypen.Senelari_Enum         => (0, 0, 1, 2),
                                                                                     RassenDatentypen.Aspari_2_Enum         => (0, 1, 1, 3),
                                                                                     RassenDatentypen.Ekropa_Enum           => (1, 0, 0, 3),
                                                                                     RassenDatentypen.Tesorahn_Enum         => (4, 0, 2, 1),
                                                                                     RassenDatentypen.Talbidahr_Enum        => (0, 0, 0, 5)
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
                                      
                                                                               KartengrundDatentypen.Flachland_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 5,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 5,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 5
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
                                      
                                                                               KartengrundDatentypen.Tundra_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 5,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 5,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 5
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
                                      
                                                                               KartengrundDatentypen.Wüste_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 5,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 5,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 5
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
                                      
                                                                                 -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                                               KartengrundDatentypen.Hügel_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 5,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 5,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 5
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
                                      
                                                                               KartengrundDatentypen.Gebirge_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 5,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 5,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 5
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
                                      
                                                                               KartengrundDatentypen.Wald_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 5,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 5,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 5
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
                                      
                                                                               KartengrundDatentypen.Dschungel_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 5,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 5,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 5
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
                                      
                                                                               KartengrundDatentypen.Küstengewässer_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                     EinheitenDatentypen.Luft_Enum         => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum     => True,
                                                                                                     EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                                     others                                => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 5,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 5,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 5
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
                                      
                                                                               KartengrundDatentypen.Sumpf_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 5,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                     RassenDatentypen.Lasupin_Enum          => 5,
                                                                                     RassenDatentypen.Lamustra_Enum         => 5,
                                                                                     RassenDatentypen.Manuky_Enum           => 5,
                                                                                     RassenDatentypen.Suroka_Enum           => 5,
                                                                                     RassenDatentypen.Pryolon_Enum          => 5,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     RassenDatentypen.Carupex_Enum          => 5,
                                                                                     RassenDatentypen.Alary_Enum            => 5,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     RassenDatentypen.Tridatus_Enum         => 5,
                                                                                     RassenDatentypen.Senelari_Enum         => 5,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                     RassenDatentypen.Ekropa_Enum           => 5,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 5
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

end KartengrundOberflaeche;
