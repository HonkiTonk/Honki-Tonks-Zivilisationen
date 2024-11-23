with KartengrundDatentypen;
with EinheitenDatentypen;
with SpeziesDatentypen;
with KartendatenbankRecord;
with DatentypenHTB6;
with ProduktionDatentypen;
with KampfDatentypen;
with KampfKonstanten;

package BasisgrundWeltall is
   pragma Pure;
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type BasisgrundlisteWeltallArray is array (KartengrundDatentypen.Basisgrund_Weltraum_Enum'Range) of KartendatenbankRecord.KartenbasisgrundlisteRecord;
   BasisgrundlisteWeltall : constant BasisgrundlisteWeltallArray := (
                                                                     KartengrundDatentypen.Weltraum_Enum =>
                                                                       (
                                                                        Passierbarkeit => (
                                                                                           EinheitenDatentypen.Weltraum_Enum => True,
                                                                                           others                            => False),
                                                                    
                                                                        Bewertung =>
                                                                          (
                                                                           SpeziesDatentypen.Menschen_Enum         => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Kasrodiah_Enum        => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Lasupin_Enum          => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Lamustra_Enum         => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Manuky_Enum           => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Suroka_Enum           => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Pryolon_Enum          => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Moru_Phisihl_Enum     => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Larinos_Lotaris_Enum  => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Carupex_Enum          => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Alary_Enum            => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Natries_Zermanis_Enum => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Tridatus_Enum         => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Senelari_Enum         => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Aspari_2_Enum         => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Ekropa_Enum           => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Tesorahn_Enum         => DatentypenHTB6.Bewertung_Sechs_Enum,
                                                                           SpeziesDatentypen.Talbidahr_Enum        => DatentypenHTB6.Bewertung_Sechs_Enum
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

end BasisgrundWeltall;
