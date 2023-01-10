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
                                                                                     SpeziesDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
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
                                                                        
                                                                                  Bewegung => (others => 8)
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
                                                                                     SpeziesDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
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
                                                                        
                                                                                  Bewegung => (others => 3)
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
                                                                                     SpeziesDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
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
                                                                        
                                                                                  Bewegung => (others => 5)
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
                                                                                     SpeziesDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
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
                                                                        
                                                                                  Bewegung => (others => 6)
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
                                                                                     SpeziesDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
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
                                                                        
                                                                                  Bewegung => (others => 3)
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
                                                                                     SpeziesDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
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
                                                                        
                                                                                  Bewegung => (others => 3)
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
                                                                                     SpeziesDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
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
                                                                        
                                                                                  Bewegung => (others => 3)
                                                                                 )
                                                                              );

end BasisgrundUnterflaeche;
