with KartengrundDatentypen;
with EinheitenDatentypen;
with RassenDatentypen;
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
                                                                                   RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Eins_Enum
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
                                                                                   RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Eins_Enum,
                                                                                   RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Eins_Enum
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
                                                                                   RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
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
                                                                                   RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
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
                                                                                   RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
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
                                                                                   RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
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
                                                                                   RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
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
                                                                                   RassenDatentypen.Menschen_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Kasrodiah_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lasupin_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Lamustra_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Manuky_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Suroka_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Pryolon_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Moru_Phisihl_Enum     => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Larinos_Lotaris_Enum  => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Carupex_Enum          => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Alary_Enum            => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Natries_Zermanis_Enum => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tridatus_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Senelari_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Aspari_2_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Ekropa_Enum           => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Tesorahn_Enum         => BewertungDatentypen.Bewertung_Sechs_Enum,
                                                                                   RassenDatentypen.Talbidahr_Enum        => BewertungDatentypen.Bewertung_Sechs_Enum
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
                                                                                  ),
                                                                        
                                                                                Bewegung => (others => 3)
                                                                               )
                                                                            );

end BasisgrundOberflaeche;
