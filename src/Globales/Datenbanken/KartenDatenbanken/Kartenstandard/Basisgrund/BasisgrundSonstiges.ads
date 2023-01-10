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

                                                                            Bewegung => (others => 10)
                                                                           )
                                                                        );

end BasisgrundSonstiges;
