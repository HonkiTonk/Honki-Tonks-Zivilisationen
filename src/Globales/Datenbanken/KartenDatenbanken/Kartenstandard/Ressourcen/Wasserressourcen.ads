with SpeziesDatentypen;
with KartendatenbankRecord;
with KartenextraDatentypen;
with ProduktionKonstanten;

package Wasserressourcen is
   pragma Pure;

   type WasserressourcenlisteArray is array (KartenextraDatentypen.Ressourcen_Oberfläche_Wasser_Enum'Range) of KartendatenbankRecord.KartenextraslisteRecord;
   Wasserressourcenliste : constant WasserressourcenlisteArray := (
                                                                   KartenextraDatentypen.Fisch_Enum =>
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
                                                                              
                                                                        -- Nahrung, Produktion, Geld, Forschung
                                                                      Wirtschaft =>
                                                                        (
                                                                         SpeziesDatentypen.Menschen_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Kasrodiah_Enum        => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Lasupin_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Lamustra_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Manuky_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Suroka_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Pryolon_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Moru_Phisihl_Enum     => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Larinos_Lotaris_Enum  => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Carupex_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Alary_Enum            => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Natries_Zermanis_Enum => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Tridatus_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Senelari_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Aspari_2_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Ekropa_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Tesorahn_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Talbidahr_Enum        => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus)
                                                                        ),
                                                                              
                                                                        -- Verteidigung, Angriff
                                                                      Kampf =>
                                                                        (
                                                                         SpeziesDatentypen.Menschen_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Kasrodiah_Enum        => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Lasupin_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Lamustra_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Manuky_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Suroka_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Pryolon_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Moru_Phisihl_Enum     => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Larinos_Lotaris_Enum  => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Carupex_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Alary_Enum            => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Natries_Zermanis_Enum => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Tridatus_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Senelari_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Aspari_2_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Ekropa_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Tesorahn_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Talbidahr_Enum        => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus)
                                                                        )
                                                                     ),
      
                                                                   KartenextraDatentypen.Wal_Enum =>
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
                                                                              
                                                                        -- Nahrung, Produktion, Geld, Forschung
                                                                      Wirtschaft =>
                                                                        (
                                                                         SpeziesDatentypen.Menschen_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Kasrodiah_Enum        => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Lasupin_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Lamustra_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Manuky_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Suroka_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Pryolon_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Moru_Phisihl_Enum     => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Larinos_Lotaris_Enum  => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Carupex_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Alary_Enum            => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Natries_Zermanis_Enum => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Tridatus_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Senelari_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Aspari_2_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Ekropa_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Tesorahn_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Talbidahr_Enum        => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus,
                                                                                                                     ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus)
                                                                        ),
                                                                              
                                                                        -- Verteidigung, Angriff
                                                                      Kampf =>
                                                                        (
                                                                         SpeziesDatentypen.Menschen_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Kasrodiah_Enum        => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Lasupin_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Lamustra_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Manuky_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Suroka_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Pryolon_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Moru_Phisihl_Enum     => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Larinos_Lotaris_Enum  => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Carupex_Enum          => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Alary_Enum            => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Natries_Zermanis_Enum => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Tridatus_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Senelari_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Aspari_2_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Ekropa_Enum           => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Tesorahn_Enum         => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus),
                                                                         SpeziesDatentypen.Talbidahr_Enum        => (ProduktionKonstanten.LeerBonus, ProduktionKonstanten.LeerBonus)
                                                                        )
                                                                     )
                                                                  );

end Wasserressourcen;
