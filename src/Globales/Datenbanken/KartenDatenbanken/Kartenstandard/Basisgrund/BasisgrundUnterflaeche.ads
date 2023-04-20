with KartengrundDatentypen;
with EinheitenDatentypen;
with SpeziesDatentypen;
with KartendatenbankRecord;
with BewertungDatentypen;

package BasisgrundUnterflaeche is
   pragma Pure;
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type BasisgrundlisteUnterflächeArray is array (KartengrundDatentypen.Basisgrund_Unterfläche_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   BasisgrundlisteUnterfläche : constant BasisgrundlisteUnterflächeArray := (
                                                                               KartengrundDatentypen.Untereis_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                     others                                => False),
                                                                    
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
                                                                                    ),
                                                                        
                                                                                  Bewegung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => 8,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => 8,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => 8,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => 8,
                                                                                     SpeziesDatentypen.Manuky_Enum           => 8,
                                                                                     SpeziesDatentypen.Suroka_Enum           => 8,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => 8,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => 8,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => 8,
                                                                                     SpeziesDatentypen.Carupex_Enum          => 8,
                                                                                     SpeziesDatentypen.Alary_Enum            => 8,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => 8,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => 8,
                                                                                     SpeziesDatentypen.Senelari_Enum         => 8,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => 8,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => 8,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => 8,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => 8
                                                                                    )
                                                                                 ),
                                      
                                                                               KartengrundDatentypen.Erde_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                     others                                => False),
                                                                    
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
                                                                                    ),
                                                                        
                                                                                  Bewegung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => 3,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => 3,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => 3,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => 3,
                                                                                     SpeziesDatentypen.Manuky_Enum           => 3,
                                                                                     SpeziesDatentypen.Suroka_Enum           => 3,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => 3,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => 3,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => 3,
                                                                                     SpeziesDatentypen.Carupex_Enum          => 3,
                                                                                     SpeziesDatentypen.Alary_Enum            => 3,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => 3,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => 3,
                                                                                     SpeziesDatentypen.Senelari_Enum         => 3,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => 3,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => 3,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => 3,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => 3
                                                                                    )
                                                                                 ),
      
                                                                               KartengrundDatentypen.Erdgestein_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                     others                                => False),
                                                                    
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
                                                                                    ),
                                                                        
                                                                                  Bewegung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => 5,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => 5,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => 5,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => 5,
                                                                                     SpeziesDatentypen.Manuky_Enum           => 5,
                                                                                     SpeziesDatentypen.Suroka_Enum           => 5,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => 5,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                     SpeziesDatentypen.Carupex_Enum          => 5,
                                                                                     SpeziesDatentypen.Alary_Enum            => 5,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => 5,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => 5,
                                                                                     SpeziesDatentypen.Senelari_Enum         => 5,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => 5,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => 5,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => 5,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => 5
                                                                                    )
                                                                                 ),
                                      
                                                                               KartengrundDatentypen.Gestein_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                     others                                => False),
                                                                                    
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
                                                                                    ),
                                                                        
                                                                                  Bewegung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => 6,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => 6,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => 6,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => 6,
                                                                                     SpeziesDatentypen.Manuky_Enum           => 6,
                                                                                     SpeziesDatentypen.Suroka_Enum           => 6,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => 6,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => 6,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => 6,
                                                                                     SpeziesDatentypen.Carupex_Enum          => 6,
                                                                                     SpeziesDatentypen.Alary_Enum            => 6,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => 6,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => 6,
                                                                                     SpeziesDatentypen.Senelari_Enum         => 6,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => 6,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => 6,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => 6,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => 6
                                                                                    )
                                                                                 ),
      
                                                                               KartengrundDatentypen.Sand_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                                     others                                => False),
                                                                    
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
                                                                                    ),
                                                                        
                                                                                  Bewegung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => 3,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => 3,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => 3,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => 3,
                                                                                     SpeziesDatentypen.Manuky_Enum           => 3,
                                                                                     SpeziesDatentypen.Suroka_Enum           => 3,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => 3,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => 3,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => 3,
                                                                                     SpeziesDatentypen.Carupex_Enum          => 3,
                                                                                     SpeziesDatentypen.Alary_Enum            => 3,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => 3,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => 3,
                                                                                     SpeziesDatentypen.Senelari_Enum         => 3,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => 3,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => 3,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => 3,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => 3
                                                                                    )
                                                                                 ),
      
                                                                               KartengrundDatentypen.Meeresgrund_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                                     others                               => False),
                                                                    
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
                                                                                    ),
                                                                        
                                                                                  Bewegung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => 3,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => 3,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => 3,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => 3,
                                                                                     SpeziesDatentypen.Manuky_Enum           => 3,
                                                                                     SpeziesDatentypen.Suroka_Enum           => 3,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => 3,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => 3,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => 3,
                                                                                     SpeziesDatentypen.Carupex_Enum          => 3,
                                                                                     SpeziesDatentypen.Alary_Enum            => 3,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => 3,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => 3,
                                                                                     SpeziesDatentypen.Senelari_Enum         => 3,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => 3,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => 3,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => 3,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => 3
                                                                                    )
                                                                                 ),
                                      
                                                                               KartengrundDatentypen.Küstengrund_Enum =>
                                                                                 (
                                                                                  Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                                     others                               => False),
                                                                    
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
                                                                                    ),
                                                                        
                                                                                  Bewegung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => 3,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => 3,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => 3,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => 3,
                                                                                     SpeziesDatentypen.Manuky_Enum           => 3,
                                                                                     SpeziesDatentypen.Suroka_Enum           => 3,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => 3,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => 3,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => 3,
                                                                                     SpeziesDatentypen.Carupex_Enum          => 3,
                                                                                     SpeziesDatentypen.Alary_Enum            => 3,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => 3,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => 3,
                                                                                     SpeziesDatentypen.Senelari_Enum         => 3,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => 3,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => 3,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => 3,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => 3
                                                                                    )
                                                                                 )
                                                                              );

end BasisgrundUnterflaeche;
