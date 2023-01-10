with KartengrundDatentypen;
with EinheitenDatentypen;
with SpeziesDatentypen;
with KartendatenbankRecord;
with BewertungDatentypen;

package BasisgrundOberflaeche is
   pragma Pure;
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type BasisgrundlisteOberflächeArray is array (KartengrundDatentypen.Basisgrund_Oberfläche_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   BasisgrundlisteOberfläche : constant BasisgrundlisteOberflächeArray := (
                                                                             KartengrundDatentypen.Eis_Enum =>
                                                                               (
                                                                                Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                   EinheitenDatentypen.Luft_Enum     => True,
                                                                                                   EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                   others                            => False),
                                                                    
                                                                                Bewertung => 
                                                                                  (
                                                                                   SpeziesDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Eins_Enum
                                                                                  ),
                                                                       
                                                                                  -- Nahrung, Produktion, Geld, Forschung
                                                                                Wirtschaft => 
                                                                                  (
                                                                                   SpeziesDatentypen.Menschen_Enum         => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Kasrodiah_Enum        => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Lasupin_Enum          => (1, 0, 0, 3),
                                                                                   SpeziesDatentypen.Lamustra_Enum         => (1, 0, 0, 3),
                                                                                   SpeziesDatentypen.Manuky_Enum           => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Suroka_Enum           => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Pryolon_Enum          => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Moru_Phisihl_Enum     => (1, 0, 0, 3),
                                                                                   SpeziesDatentypen.Larinos_Lotaris_Enum  => (1, 0, 0, 3),
                                                                                   SpeziesDatentypen.Carupex_Enum          => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Alary_Enum            => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Natries_Zermanis_Enum => (1, 0, 0, 3),
                                                                                   SpeziesDatentypen.Tridatus_Enum         => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Senelari_Enum         => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Aspari_2_Enum         => (1, 1, 0, 1),
                                                                                   SpeziesDatentypen.Ekropa_Enum           => (0, 0, 0, 3),
                                                                                   SpeziesDatentypen.Tesorahn_Enum         => (0, 0, 0, 5),
                                                                                   SpeziesDatentypen.Talbidahr_Enum        => (0, 0, 0, 3)
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
     
                                                                             KartengrundDatentypen.Wasser_Enum =>
                                                                               (
                                                                                Passierbarkeit => (EinheitenDatentypen.Wasser_Enum   => True,
                                                                                                   EinheitenDatentypen.Luft_Enum     => True,
                                                                                                   EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                   others                            => False),
                                                                    
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
                                                                                   SpeziesDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   SpeziesDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   SpeziesDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   SpeziesDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   SpeziesDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   SpeziesDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Eins_Enum
                                                                                  ),
                                                                       
                                                                                  -- Nahrung, Produktion, Geld, Forschung
                                                                                Wirtschaft => 
                                                                                  (
                                                                                   SpeziesDatentypen.Menschen_Enum         => (2, 0, 1, 2),
                                                                                   SpeziesDatentypen.Kasrodiah_Enum        => (2, 0, 1, 2),
                                                                                   SpeziesDatentypen.Lasupin_Enum          => (2, 0, 1, 2),
                                                                                   SpeziesDatentypen.Lamustra_Enum         => (2, 0, 1, 2),
                                                                                   SpeziesDatentypen.Manuky_Enum           => (1, 0, 1, 2),
                                                                                   SpeziesDatentypen.Suroka_Enum           => (2, 0, 1, 2),
                                                                                   SpeziesDatentypen.Pryolon_Enum          => (1, 0, 1, 2),
                                                                                   SpeziesDatentypen.Moru_Phisihl_Enum     => (2, 0, 1, 2),
                                                                                   SpeziesDatentypen.Larinos_Lotaris_Enum  => (2, 0, 1, 2),
                                                                                   SpeziesDatentypen.Carupex_Enum          => (0, 0, 1, 3),
                                                                                   SpeziesDatentypen.Alary_Enum            => (1, 0, 1, 2),
                                                                                   SpeziesDatentypen.Natries_Zermanis_Enum => (0, 0, 1, 3),
                                                                                   SpeziesDatentypen.Tridatus_Enum         => (2, 0, 1, 3),
                                                                                   SpeziesDatentypen.Senelari_Enum         => (0, 0, 1, 2),
                                                                                   SpeziesDatentypen.Aspari_2_Enum         => (0, 1, 1, 3),
                                                                                   SpeziesDatentypen.Ekropa_Enum           => (1, 0, 0, 3),
                                                                                   SpeziesDatentypen.Tesorahn_Enum         => (4, 0, 2, 1),
                                                                                   SpeziesDatentypen.Talbidahr_Enum        => (0, 0, 0, 5)
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
                                      
                                                                             KartengrundDatentypen.Flachland_Enum =>
                                                                               (
                                                                                Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                   EinheitenDatentypen.Luft_Enum     => True,
                                                                                                   EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                   others                            => False),
                                                                    
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
                                      
                                                                             KartengrundDatentypen.Tundra_Enum =>
                                                                               (
                                                                                Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                   EinheitenDatentypen.Luft_Enum     => True,
                                                                                                   EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                   others                            => False),
                                                                    
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
                                      
                                                                             KartengrundDatentypen.Wüste_Enum =>
                                                                               (
                                                                                Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                   EinheitenDatentypen.Luft_Enum     => True,
                                                                                                   EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                   others                            => False),
                                                                    
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
                                      
                                                                               -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                                             KartengrundDatentypen.Basisgrund_Hügel_Enum'Range =>
                                                                               (
                                                                                Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                   EinheitenDatentypen.Luft_Enum     => True,
                                                                                                   EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                   others                            => False),
                                                                    
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
                                                                        
                                                                                Bewegung => (others => 4)
                                                                               ),
                                      
                                                                             KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
                                                                               (
                                                                                Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                   EinheitenDatentypen.Luft_Enum     => True,
                                                                                                   EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                   others                            => False),
                                                                    
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
                                                                                                                                                           
                                                                             KartengrundDatentypen.Küstengewässer_Enum =>
                                                                               (
                                                                                Passierbarkeit => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                                   EinheitenDatentypen.Luft_Enum         => True,
                                                                                                   EinheitenDatentypen.Weltraum_Enum     => True,
                                                                                                   EinheitenDatentypen.Küstenwasser_Enum => True,
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
                                                                               )
                                                                            );

end BasisgrundOberflaeche;
