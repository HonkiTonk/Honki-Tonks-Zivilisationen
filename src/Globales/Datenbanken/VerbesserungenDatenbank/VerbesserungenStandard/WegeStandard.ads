with KartenverbesserungDatentypen;
with EinheitenDatentypen;
with KartendatenbankRecord;
with ProduktionKonstanten;
with ProduktionDatentypen;
with KampfDatentypen;
with SpeziesDatentypen;

package WegeStandard is
   pragma Pure;
   use type EinheitenDatentypen.Bewegungspunkte;

   type WegelisteArray is array (KartenverbesserungDatentypen.Straße_Enum'Range) of KartendatenbankRecord.WegelisteRecord;
   Wegeliste : constant WegelisteArray := (
                                           others =>
                                             (
                                              Passierbarkeit =>
                                                (
                                                 EinheitenDatentypen.Boden_Enum    => True,
                                                 EinheitenDatentypen.Luft_Enum     => True,
                                                 EinheitenDatentypen.Weltraum_Enum => True,
                                                 others                            => False
                                                ),
                                                                                                                                           
                                              Wirtschaft =>
                                                (
                                                 ProduktionDatentypen.Nahrung_Enum =>
                                                   (
                                                    SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                   ),
                                                   
                                                 ProduktionDatentypen.Material_Enum =>
                                                   (
                                                    SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                   ),
                                                                         
                                                 ProduktionDatentypen.Geld_Enum =>
                                                   (
                                                    SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                   ),
                                                                         
                                                 ProduktionDatentypen.Forschung_Enum =>
                                                   (
                                                    SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                   )
                                                ),

                                              Kampf =>
                                                (
                                                 KampfDatentypen.Angriff_Enum =>
                                                   (
                                                    SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                   ),
                                                                         
                                                 KampfDatentypen.Verteidigung_Enum =>
                                                   (
                                                    SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                    SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                   )
                                                ),
                                                  
                                              Bewegung =>
                                                (
                                                 others => -1
                                                )
                                             )
                                          );
                                           
   
   
   type SchienenlisteArray is array (KartenverbesserungDatentypen.Schiene_Enum'Range) of KartendatenbankRecord.WegelisteRecord;
   Schienenliste : constant SchienenlisteArray := (
                                                   others =>
                                                     (
                                                      Passierbarkeit =>
                                                        (
                                                         EinheitenDatentypen.Boden_Enum    => True,
                                                         EinheitenDatentypen.Luft_Enum     => True,
                                                         EinheitenDatentypen.Weltraum_Enum => True,
                                                         others                            => False
                                                        ),
                                                                                                                                           
                                                      Wirtschaft =>
                                                        (
                                                         ProduktionDatentypen.Nahrung_Enum =>
                                                           (
                                                            SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                           ),
                                                   
                                                         ProduktionDatentypen.Material_Enum =>
                                                           (
                                                            SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                           ),
                                                                         
                                                         ProduktionDatentypen.Geld_Enum =>
                                                           (
                                                            SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                           ),
                                                                         
                                                         ProduktionDatentypen.Forschung_Enum =>
                                                           (
                                                            SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                           )
                                                        ),

                                                      Kampf =>
                                                        (
                                                         KampfDatentypen.Angriff_Enum =>
                                                           (
                                                            SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                           ),
                                                                         
                                                         KampfDatentypen.Verteidigung_Enum =>
                                                           (
                                                            SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                            SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                           )
                                                        ),
                                                      
                                                      Bewegung =>
                                                        (
                                                         others => -2
                                                        )
                                                     )
                                                  );
   
   
   
   type TunnellisteArray is array (KartenverbesserungDatentypen.Tunnel_Enum'Range) of KartendatenbankRecord.WegelisteRecord;
   Tunnelliste : constant TunnellisteArray := (
                                               others =>
                                                 (
                                                  Passierbarkeit =>
                                                    (
                                                     EinheitenDatentypen.Unterirdisch_Enum => True,
                                                     others                                => False
                                                    ),
                                                                                                                                           
                                                  Wirtschaft =>
                                                    (
                                                     ProduktionDatentypen.Nahrung_Enum =>
                                                       (
                                                        SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                       ),
                                                   
                                                     ProduktionDatentypen.Material_Enum =>
                                                       (
                                                        SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                       ),
                                                                         
                                                     ProduktionDatentypen.Geld_Enum =>
                                                       (
                                                        SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                       ),
                                                                         
                                                     ProduktionDatentypen.Forschung_Enum =>
                                                       (
                                                        SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                       )
                                                    ),

                                                  Kampf =>
                                                    (
                                                     KampfDatentypen.Angriff_Enum =>
                                                       (
                                                        SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                       ),
                                                                         
                                                     KampfDatentypen.Verteidigung_Enum =>
                                                       (
                                                        SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerBonus,
                                                        SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerBonus
                                                       )
                                                    ),
                                                  
                                                  Bewegung =>
                                                    (
                                                     others => -1
                                                    )
                                                 )
                                              );

end WegeStandard;
