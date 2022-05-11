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
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
     
                                                                               KartengrundDatentypen.Wasser_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Wasser_Enum   => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                      
                                                                               KartengrundDatentypen.Flachland_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
                                      
                                                                                 -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr draus machen?
                                                                               KartengrundDatentypen.Hügel_Mit_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                     others                            => False),
                                                                    
                                                                                  Bewertung => 
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => 1,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                     RassenDatentypen.Lasupin_Enum          => 1,
                                                                                     RassenDatentypen.Lamustra_Enum         => 1,
                                                                                     RassenDatentypen.Manuky_Enum           => 1,
                                                                                     RassenDatentypen.Suroka_Enum           => 1,
                                                                                     RassenDatentypen.Pryolon_Enum          => 1,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                     RassenDatentypen.Carupex_Enum          => 1,
                                                                                     RassenDatentypen.Alary_Enum            => 1,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                     RassenDatentypen.Tridatus_Enum         => 1,
                                                                                     RassenDatentypen.Senelari_Enum         => 1,
                                                                                     RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                     RassenDatentypen.Ekropa_Enum           => 1,
                                                                                     RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                     RassenDatentypen.Talbidahr_Enum        => 1
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
