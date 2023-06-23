with KartenextraDatentypen;
with KartendatenbankRecord;
with SpeziesDatentypen;
with ProduktionKonstanten;
with ProduktionDatentypen;
with KampfDatentypen;
with KampfKonstanten;

package EffekteStandard is
   pragma Pure;

   type EffektelisteArray is array (KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenextraslisteRecord;
   Effekteliste : constant EffektelisteArray := (
                                                 others =>
                                                   (
                                                    Bewertung =>
                                                      (
                                                       SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.MalusVorhanden,
                                                       SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.MalusVorhanden
                                                      ),
                                                                              
                                                      -- Nahrung, Produktion, Geld, Forschung
                                                    Wirtschaft =>
                                                      (
                                                       ProduktionDatentypen.Nahrung_Enum =>
                                                         (
                                                          SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerMalus
                                                         ),
                                                                         
                                                       ProduktionDatentypen.Material_Enum =>
                                                         (
                                                          SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerMalus
                                                         ),
                                                                         
                                                       ProduktionDatentypen.Geld_Enum =>
                                                         (
                                                          SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerMalus
                                                         ),
                                                                         
                                                       ProduktionDatentypen.Forschung_Enum =>
                                                         (
                                                          SpeziesDatentypen.Menschen_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Kasrodiah_Enum        => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lasupin_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lamustra_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Manuky_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Suroka_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Pryolon_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Carupex_Enum          => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Alary_Enum            => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Natries_Zermanis_Enum => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tridatus_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Senelari_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Aspari_2_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Ekropa_Enum           => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tesorahn_Enum         => ProduktionKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Talbidahr_Enum        => ProduktionKonstanten.LeerMalus
                                                         )
                                                      ),

                                                    Kampf =>
                                                      (
                                                       KampfDatentypen.Angriff_Enum =>
                                                         (
                                                          SpeziesDatentypen.Menschen_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Kasrodiah_Enum        => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lasupin_Enum          => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lamustra_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Manuky_Enum           => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Suroka_Enum           => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Pryolon_Enum          => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Carupex_Enum          => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Alary_Enum            => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Natries_Zermanis_Enum => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tridatus_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Senelari_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Aspari_2_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Ekropa_Enum           => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tesorahn_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Talbidahr_Enum        => KampfKonstanten.LeerMalus
                                                         ),
                                                                         
                                                       KampfDatentypen.Verteidigung_Enum =>
                                                         (
                                                          SpeziesDatentypen.Menschen_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Kasrodiah_Enum        => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lasupin_Enum          => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Lamustra_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Manuky_Enum           => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Suroka_Enum           => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Pryolon_Enum          => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Carupex_Enum          => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Alary_Enum            => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Natries_Zermanis_Enum => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tridatus_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Senelari_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Aspari_2_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Ekropa_Enum           => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Tesorahn_Enum         => KampfKonstanten.LeerMalus,
                                                          SpeziesDatentypen.Talbidahr_Enum        => KampfKonstanten.LeerMalus
                                                         )
                                                      )
                                                   )
                                                );

end EffekteStandard;
