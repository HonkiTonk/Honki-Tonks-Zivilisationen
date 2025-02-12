with KartengrundDatentypen;
with SpeziesDatentypen;
with KartendatenbankRecord;
with ZufallsgeneratorenDatentypenHTSEB;
with ProduktionDatentypen;
with KampfDatentypen;
with KampfKonstanten;

package ZusatzgrundOberflaeche is
   pragma Pure;
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type ZusatzgrundlisteOberflächeArray is array (KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum'Range) of KartendatenbankRecord.KartenzusatzgrundlisteRecord;
   ZusatzgrundlisteOberfläche : constant ZusatzgrundlisteOberflächeArray := (
                                                                               KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range =>
                                                                                 (
                                                                                  Bewertung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Manuky_Enum           => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Suroka_Enum           => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Carupex_Enum          => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Alary_Enum            => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Senelari_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum
                                                                                    ),

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

                                                                               KartengrundDatentypen.Zusatzgrund_Dschungel_Enum'Range =>
                                                                                 (
                                                                                  Bewertung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Manuky_Enum           => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Suroka_Enum           => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Carupex_Enum          => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Alary_Enum            => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Senelari_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum
                                                                                    ),

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

                                                                               KartengrundDatentypen.Zusatzgrund_Sumpf_Enum'Range =>
                                                                                 (
                                                                                  Bewertung =>
                                                                                    (
                                                                                     SpeziesDatentypen.Menschen_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Kasrodiah_Enum        => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lasupin_Enum          => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Lamustra_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Manuky_Enum           => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Suroka_Enum           => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Pryolon_Enum          => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Carupex_Enum          => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Alary_Enum            => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tridatus_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Senelari_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Aspari_2_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Ekropa_Enum           => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Tesorahn_Enum         => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum,
                                                                                     SpeziesDatentypen.Talbidahr_Enum        => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Sechs_Enum
                                                                                    ),

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

end ZusatzgrundOberflaeche;
