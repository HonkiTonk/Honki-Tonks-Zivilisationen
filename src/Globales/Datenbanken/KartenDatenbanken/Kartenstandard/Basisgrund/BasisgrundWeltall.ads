with KartengrundDatentypen;
with EinheitenDatentypen;
with SpeziesDatentypen;
with KartendatenbankRecord;
with BewertungDatentypen;

package BasisgrundWeltall is
   pragma Pure;
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type BasisgrundlisteWeltallArray is array (KartengrundDatentypen.Basisgrund_Weltraum_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   BasisgrundlisteWeltall : constant BasisgrundlisteWeltallArray := (
                                                                     KartengrundDatentypen.Weltraum_Enum =>
                                                                       (
                                                                        Passierbarkeit => (
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

end BasisgrundWeltall;
