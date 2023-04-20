with KartengrundDatentypen;
with EinheitenDatentypen;
with SpeziesDatentypen;
with KartendatenbankRecord;
with BewertungDatentypen;

package BasisgrundSonstiges is
   pragma Pure;

   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type BasisgrundlisteSonstigesArray is array (KartengrundDatentypen.Basisgrund_Sonstiges_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   BasisgrundlisteSonstiges : constant BasisgrundlisteSonstigesArray := (
                                                                         KartengrundDatentypen.Vernichtet_Enum =>
                                                                           (
                                                                            Passierbarkeit => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                               EinheitenDatentypen.Weltraum_Enum => True,
                                                                                               others                            => False),
                                                                            Bewertung      => (others => BewertungDatentypen.Bewertung_Eins_Enum),

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
                                                                               SpeziesDatentypen.Menschen_Enum         => 10,
                                                                               SpeziesDatentypen.Kasrodiah_Enum        => 10,
                                                                               SpeziesDatentypen.Lasupin_Enum          => 10,
                                                                               SpeziesDatentypen.Lamustra_Enum         => 10,
                                                                               SpeziesDatentypen.Manuky_Enum           => 10,
                                                                               SpeziesDatentypen.Suroka_Enum           => 10,
                                                                               SpeziesDatentypen.Pryolon_Enum          => 10,
                                                                               SpeziesDatentypen.Moru_Phisihl_Enum     => 10,
                                                                               SpeziesDatentypen.Larinos_Lotaris_Enum  => 10,
                                                                               SpeziesDatentypen.Carupex_Enum          => 10,
                                                                               SpeziesDatentypen.Alary_Enum            => 10,
                                                                               SpeziesDatentypen.Natries_Zermanis_Enum => 10,
                                                                               SpeziesDatentypen.Tridatus_Enum         => 10,
                                                                               SpeziesDatentypen.Senelari_Enum         => 10,
                                                                               SpeziesDatentypen.Aspari_2_Enum         => 10,
                                                                               SpeziesDatentypen.Ekropa_Enum           => 10,
                                                                               SpeziesDatentypen.Tesorahn_Enum         => 10,
                                                                               SpeziesDatentypen.Talbidahr_Enum        => 10
                                                                              )
                                                                           )
                                                                        );

end BasisgrundSonstiges;
