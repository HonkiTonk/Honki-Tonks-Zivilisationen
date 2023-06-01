with KartenverbesserungDatentypen;
with KartendatenbankRecord;
with ProduktionKonstanten;
with ProduktionDatentypen;
with KampfDatentypen;
with SpeziesDatentypen;

package VerbesserungenStandard is
   pragma Pure;
   
   type StadtlisteArray is array (KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Range) of KartendatenbankRecord.VerbesserungenlisteRecord;
   Stadtliste : constant StadtlisteArray := (
                                             KartenverbesserungDatentypen.Hauptstadt_Enum =>
                                               (
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
                                                  )
                                               ),
                                                  
                                             KartenverbesserungDatentypen.Stadt_Enum =>
                                               (
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
                                                  )
                                               )
                                            );
   
   
   
   type GebildelisteArray is array (KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum'Range) of KartendatenbankRecord.VerbesserungenlisteRecord;
   Gebildeliste : constant GebildelisteArray := (
                                                 KartenverbesserungDatentypen.Farm_Enum =>
                                                   (
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
                                                      )
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Mine_Enum =>
                                                   (
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
                                                      )
                                                   ),
                                                  
                                                 KartenverbesserungDatentypen.Festung_Enum =>
                                                   (
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
                                                      )
                                                   )
                                                );

end VerbesserungenStandard;
