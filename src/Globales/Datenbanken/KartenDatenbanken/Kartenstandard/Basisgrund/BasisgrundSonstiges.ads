with KartengrundDatentypen;
with EinheitenDatentypen;
with SpeziesDatentypen;
with KartendatenbankRecord;
with BewertungDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;
with KampfKonstanten;

package BasisgrundSonstiges is
   pragma Pure;

   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type BasisgrundlisteSonstigesArray is array (KartengrundDatentypen.Basisgrund_Sonstiges_Enum'Range) of KartendatenbankRecord.KartenbasisgrundlisteRecord;
   BasisgrundlisteSonstiges : constant BasisgrundlisteSonstigesArray := (
                                                                         KartengrundDatentypen.Vernichtet_Enum =>
                                                                           (
                                                                            Passierbarkeit => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                               EinheitenDatentypen.Weltraum_Enum => True,
                                                                                               others                            => False),
                                                                            Bewertung      => (others => BewertungDatentypen.Bewertung_Eins_Enum),

                                                                            Wirtschaft =>
                                                                              (
                                                                               ProduktionDatentypen.Nahrung_Enum =>
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
                                                                                 ),

                                                                               ProduktionDatentypen.Material_Enum =>
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
                                                                                 ),

                                                                               ProduktionDatentypen.Geld_Enum =>
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
                                                                                 ),

                                                                               ProduktionDatentypen.Forschung_Enum =>
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

                                                                            Kampf =>
                                                                              (
                                                                               KampfDatentypen.Angriff_Enum =>
                                                                                 (
                                                                                  SpeziesDatentypen.Menschen_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Kasrodiah_Enum        => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Lasupin_Enum          => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Lamustra_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Manuky_Enum           => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Suroka_Enum           => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Pryolon_Enum          => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Moru_Phisihl_Enum     => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Larinos_Lotaris_Enum  => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Carupex_Enum          => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Alary_Enum            => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Natries_Zermanis_Enum => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Tridatus_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Senelari_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Aspari_2_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Ekropa_Enum           => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Tesorahn_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Talbidahr_Enum        => KampfKonstanten.LeerBonus
                                                                                 ),

                                                                               KampfDatentypen.Verteidigung_Enum =>
                                                                                 (
                                                                                  SpeziesDatentypen.Menschen_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Kasrodiah_Enum        => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Lasupin_Enum          => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Lamustra_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Manuky_Enum           => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Suroka_Enum           => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Pryolon_Enum          => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Moru_Phisihl_Enum     => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Larinos_Lotaris_Enum  => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Carupex_Enum          => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Alary_Enum            => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Natries_Zermanis_Enum => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Tridatus_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Senelari_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Aspari_2_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Ekropa_Enum           => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Tesorahn_Enum         => KampfKonstanten.LeerBonus,
                                                                                  SpeziesDatentypen.Talbidahr_Enum        => KampfKonstanten.LeerBonus
                                                                                 )
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
