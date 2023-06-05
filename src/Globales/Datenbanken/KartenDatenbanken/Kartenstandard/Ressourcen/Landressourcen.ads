with SpeziesDatentypen;
with KartendatenbankRecord;
with KartenextraDatentypen;
with ProduktionKonstanten;
with ProduktionDatentypen;
with KampfDatentypen;
with KampfKonstanten;

package Landressourcen is
   pragma Pure;

   type LandressourcenlisteArray is array (KartenextraDatentypen.Ressourcen_Oberfläche_Land_Enum'Range) of KartendatenbankRecord.KartenextraslisteRecord;
   Landressourcenliste : constant LandressourcenlisteArray := (
                                                               KartenextraDatentypen.Kohle_Enum =>
                                                                 (
                                                                  Bewertung  =>
                                                                    (
                                                                     SpeziesDatentypen.Menschen_Enum         => True,
                                                                     SpeziesDatentypen.Kasrodiah_Enum        => True,
                                                                     SpeziesDatentypen.Lasupin_Enum          => True,
                                                                     SpeziesDatentypen.Lamustra_Enum         => True,
                                                                     SpeziesDatentypen.Manuky_Enum           => True,
                                                                     SpeziesDatentypen.Suroka_Enum           => True,
                                                                     SpeziesDatentypen.Pryolon_Enum          => True,
                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => True,
                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => True,
                                                                     SpeziesDatentypen.Carupex_Enum          => True,
                                                                     SpeziesDatentypen.Alary_Enum            => True,
                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => True,
                                                                     SpeziesDatentypen.Tridatus_Enum         => True,
                                                                     SpeziesDatentypen.Senelari_Enum         => True,
                                                                     SpeziesDatentypen.Aspari_2_Enum         => True,
                                                                     SpeziesDatentypen.Ekropa_Enum           => True,
                                                                     SpeziesDatentypen.Tesorahn_Enum         => True,
                                                                     SpeziesDatentypen.Talbidahr_Enum        => True
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
                                                                    )
                                                                 ),
                                                                  
                                                               KartenextraDatentypen.Eisen_Enum =>
                                                                 (
                                                                  Bewertung  =>
                                                                    (
                                                                     SpeziesDatentypen.Menschen_Enum         => True,
                                                                     SpeziesDatentypen.Kasrodiah_Enum        => True,
                                                                     SpeziesDatentypen.Lasupin_Enum          => True,
                                                                     SpeziesDatentypen.Lamustra_Enum         => True,
                                                                     SpeziesDatentypen.Manuky_Enum           => True,
                                                                     SpeziesDatentypen.Suroka_Enum           => True,
                                                                     SpeziesDatentypen.Pryolon_Enum          => True,
                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => True,
                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => True,
                                                                     SpeziesDatentypen.Carupex_Enum          => True,
                                                                     SpeziesDatentypen.Alary_Enum            => True,
                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => True,
                                                                     SpeziesDatentypen.Tridatus_Enum         => True,
                                                                     SpeziesDatentypen.Senelari_Enum         => True,
                                                                     SpeziesDatentypen.Aspari_2_Enum         => True,
                                                                     SpeziesDatentypen.Ekropa_Enum           => True,
                                                                     SpeziesDatentypen.Tesorahn_Enum         => True,
                                                                     SpeziesDatentypen.Talbidahr_Enum        => True
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
                                                                    )
                                                                 ),
                                      
                                                               KartenextraDatentypen.Öl_Enum =>
                                                                 (
                                                                  Bewertung  =>
                                                                    (
                                                                     SpeziesDatentypen.Menschen_Enum         => True,
                                                                     SpeziesDatentypen.Kasrodiah_Enum        => True,
                                                                     SpeziesDatentypen.Lasupin_Enum          => True,
                                                                     SpeziesDatentypen.Lamustra_Enum         => True,
                                                                     SpeziesDatentypen.Manuky_Enum           => True,
                                                                     SpeziesDatentypen.Suroka_Enum           => True,
                                                                     SpeziesDatentypen.Pryolon_Enum          => True,
                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => True,
                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => True,
                                                                     SpeziesDatentypen.Carupex_Enum          => True,
                                                                     SpeziesDatentypen.Alary_Enum            => True,
                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => True,
                                                                     SpeziesDatentypen.Tridatus_Enum         => True,
                                                                     SpeziesDatentypen.Senelari_Enum         => True,
                                                                     SpeziesDatentypen.Aspari_2_Enum         => True,
                                                                     SpeziesDatentypen.Ekropa_Enum           => True,
                                                                     SpeziesDatentypen.Tesorahn_Enum         => True,
                                                                     SpeziesDatentypen.Talbidahr_Enum        => True
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
                                                                    )
                                                                 ),
                                                                           
                                                               KartenextraDatentypen.Hochwertiger_Boden_Enum =>
                                                                 (
                                                                  Bewertung  =>
                                                                    (
                                                                     SpeziesDatentypen.Menschen_Enum         => True,
                                                                     SpeziesDatentypen.Kasrodiah_Enum        => True,
                                                                     SpeziesDatentypen.Lasupin_Enum          => True,
                                                                     SpeziesDatentypen.Lamustra_Enum         => True,
                                                                     SpeziesDatentypen.Manuky_Enum           => True,
                                                                     SpeziesDatentypen.Suroka_Enum           => True,
                                                                     SpeziesDatentypen.Pryolon_Enum          => True,
                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => True,
                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => True,
                                                                     SpeziesDatentypen.Carupex_Enum          => True,
                                                                     SpeziesDatentypen.Alary_Enum            => True,
                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => True,
                                                                     SpeziesDatentypen.Tridatus_Enum         => True,
                                                                     SpeziesDatentypen.Senelari_Enum         => True,
                                                                     SpeziesDatentypen.Aspari_2_Enum         => True,
                                                                     SpeziesDatentypen.Ekropa_Enum           => True,
                                                                     SpeziesDatentypen.Tesorahn_Enum         => True,
                                                                     SpeziesDatentypen.Talbidahr_Enum        => True
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
                                                                    )
                                                                 ),
                                                                           
                                                               KartenextraDatentypen.Hochwertiges_Holz_Enum =>
                                                                 (
                                                                  Bewertung  =>
                                                                    (
                                                                     SpeziesDatentypen.Menschen_Enum         => True,
                                                                     SpeziesDatentypen.Kasrodiah_Enum        => True,
                                                                     SpeziesDatentypen.Lasupin_Enum          => True,
                                                                     SpeziesDatentypen.Lamustra_Enum         => True,
                                                                     SpeziesDatentypen.Manuky_Enum           => True,
                                                                     SpeziesDatentypen.Suroka_Enum           => True,
                                                                     SpeziesDatentypen.Pryolon_Enum          => True,
                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => True,
                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => True,
                                                                     SpeziesDatentypen.Carupex_Enum          => True,
                                                                     SpeziesDatentypen.Alary_Enum            => True,
                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => True,
                                                                     SpeziesDatentypen.Tridatus_Enum         => True,
                                                                     SpeziesDatentypen.Senelari_Enum         => True,
                                                                     SpeziesDatentypen.Aspari_2_Enum         => True,
                                                                     SpeziesDatentypen.Ekropa_Enum           => True,
                                                                     SpeziesDatentypen.Tesorahn_Enum         => True,
                                                                     SpeziesDatentypen.Talbidahr_Enum        => True
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
                                                                    )
                                                                 ),
                                      
                                                               KartenextraDatentypen.Gold_Enum =>
                                                                 (
                                                                  Bewertung  =>
                                                                    (
                                                                     SpeziesDatentypen.Menschen_Enum         => True,
                                                                     SpeziesDatentypen.Kasrodiah_Enum        => True,
                                                                     SpeziesDatentypen.Lasupin_Enum          => True,
                                                                     SpeziesDatentypen.Lamustra_Enum         => True,
                                                                     SpeziesDatentypen.Manuky_Enum           => True,
                                                                     SpeziesDatentypen.Suroka_Enum           => True,
                                                                     SpeziesDatentypen.Pryolon_Enum          => True,
                                                                     SpeziesDatentypen.Moru_Phisihl_Enum     => True,
                                                                     SpeziesDatentypen.Larinos_Lotaris_Enum  => True,
                                                                     SpeziesDatentypen.Carupex_Enum          => True,
                                                                     SpeziesDatentypen.Alary_Enum            => True,
                                                                     SpeziesDatentypen.Natries_Zermanis_Enum => True,
                                                                     SpeziesDatentypen.Tridatus_Enum         => True,
                                                                     SpeziesDatentypen.Senelari_Enum         => True,
                                                                     SpeziesDatentypen.Aspari_2_Enum         => True,
                                                                     SpeziesDatentypen.Ekropa_Enum           => True,
                                                                     SpeziesDatentypen.Tesorahn_Enum         => True,
                                                                     SpeziesDatentypen.Talbidahr_Enum        => True
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
                                                                    )
                                                                 )
                                                              );

end Landressourcen;
