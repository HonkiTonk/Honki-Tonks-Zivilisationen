with SpeziesDatentypen;
with ForschungsdatenbankRecord;
with ForschungKonstanten;
with AufgabenDatentypen;
with SystemDatentypen;
with BefehleDatentypen;
with KartengrundDatentypen;
with ForschungenDatentypen;

package ForschungRecordKonstanten is
   pragma Pure;

   LeerForschungsliste : constant ForschungsdatenbankRecord.ForschungslisteRecord := (
                                                                                      Kosten      => ForschungKonstanten.LeerKosten,
                                                                                      Anforderung => (others => ForschungKonstanten.ForschungUnmöglich)
                                                                                     );
   
   -- Das hier als Standard nehmen und Laden wenn keine Datenbank verfügbar ist, dafür eine Datenbank anlegen. äöü
   type TechnologieVerbesserungenArray is array (BefehleDatentypen.Siedler_Verbesserung_Enum'Range, SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   StandardtechnologieVerbesserungen : constant TechnologieVerbesserungenArray := (
                                                                                   BefehleDatentypen.Straße_Bauen_Enum =>
                                                                                     (
                                                                                      SpeziesDatentypen.Menschen_Enum         => 0,
                                                                                      SpeziesDatentypen.Kasrodiah_Enum        => 0,
                                                                                      SpeziesDatentypen.Lasupin_Enum          => 0,
                                                                                      SpeziesDatentypen.Lamustra_Enum         => 0,
                                                                                      SpeziesDatentypen.Manuky_Enum           => 0,
                                                                                      SpeziesDatentypen.Suroka_Enum           => 0,
                                                                                      SpeziesDatentypen.Pryolon_Enum          => 0,
                                                                                      SpeziesDatentypen.Moru_Phisihl_Enum     => 0,
                                                                                      SpeziesDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                                      SpeziesDatentypen.Carupex_Enum          => 0,
                                                                                      SpeziesDatentypen.Alary_Enum            => 0,
                                                                                      SpeziesDatentypen.Natries_Zermanis_Enum => 0,
                                                                                      SpeziesDatentypen.Tridatus_Enum         => 0,
                                                                                      SpeziesDatentypen.Senelari_Enum         => 0,
                                                                                      SpeziesDatentypen.Aspari_2_Enum         => 0,
                                                                                      SpeziesDatentypen.Ekropa_Enum           => 0,
                                                                                      SpeziesDatentypen.Tesorahn_Enum         => 0,
                                                                                      SpeziesDatentypen.Talbidahr_Enum        => 0
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Wald_Aufforsten_Enum =>
                                                                                     (
                                                                                      SpeziesDatentypen.Menschen_Enum         => 0,
                                                                                      SpeziesDatentypen.Kasrodiah_Enum        => 0,
                                                                                      SpeziesDatentypen.Lasupin_Enum          => 0,
                                                                                      SpeziesDatentypen.Lamustra_Enum         => 0,
                                                                                      SpeziesDatentypen.Manuky_Enum           => 0,
                                                                                      SpeziesDatentypen.Suroka_Enum           => 0,
                                                                                      SpeziesDatentypen.Pryolon_Enum          => 0,
                                                                                      SpeziesDatentypen.Moru_Phisihl_Enum     => 0,
                                                                                      SpeziesDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                                      SpeziesDatentypen.Carupex_Enum          => 0,
                                                                                      SpeziesDatentypen.Alary_Enum            => 0,
                                                                                      SpeziesDatentypen.Natries_Zermanis_Enum => 0,
                                                                                      SpeziesDatentypen.Tridatus_Enum         => 0,
                                                                                      SpeziesDatentypen.Senelari_Enum         => 0,
                                                                                      SpeziesDatentypen.Aspari_2_Enum         => 0,
                                                                                      SpeziesDatentypen.Ekropa_Enum           => 0,
                                                                                      SpeziesDatentypen.Tesorahn_Enum         => 0,
                                                                                      SpeziesDatentypen.Talbidahr_Enum        => 0
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Mine_Bauen_Enum =>
                                                                                     (
                                                                                      SpeziesDatentypen.Menschen_Enum         => 6,
                                                                                      SpeziesDatentypen.Kasrodiah_Enum        => 6,
                                                                                      SpeziesDatentypen.Lasupin_Enum          => 6,
                                                                                      SpeziesDatentypen.Lamustra_Enum         => 6,
                                                                                      SpeziesDatentypen.Manuky_Enum           => 6,
                                                                                      SpeziesDatentypen.Suroka_Enum           => 6,
                                                                                      SpeziesDatentypen.Pryolon_Enum          => 6,
                                                                                      SpeziesDatentypen.Moru_Phisihl_Enum     => 6,
                                                                                      SpeziesDatentypen.Larinos_Lotaris_Enum  => 6,
                                                                                      SpeziesDatentypen.Carupex_Enum          => 6,
                                                                                      SpeziesDatentypen.Alary_Enum            => 6,
                                                                                      SpeziesDatentypen.Natries_Zermanis_Enum => 6,
                                                                                      SpeziesDatentypen.Tridatus_Enum         => 6,
                                                                                      SpeziesDatentypen.Senelari_Enum         => 6,
                                                                                      SpeziesDatentypen.Aspari_2_Enum         => 6,
                                                                                      SpeziesDatentypen.Ekropa_Enum           => 6,
                                                                                      SpeziesDatentypen.Tesorahn_Enum         => 6,
                                                                                      SpeziesDatentypen.Talbidahr_Enum        => 6
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Farm_Bauen_Enum =>
                                                                                     (
                                                                                      SpeziesDatentypen.Menschen_Enum         => 2,
                                                                                      SpeziesDatentypen.Kasrodiah_Enum        => 2,
                                                                                      SpeziesDatentypen.Lasupin_Enum          => 2,
                                                                                      SpeziesDatentypen.Lamustra_Enum         => 2,
                                                                                      SpeziesDatentypen.Manuky_Enum           => 2,
                                                                                      SpeziesDatentypen.Suroka_Enum           => 2,
                                                                                      SpeziesDatentypen.Pryolon_Enum          => 2,
                                                                                      SpeziesDatentypen.Moru_Phisihl_Enum     => 2,
                                                                                      SpeziesDatentypen.Larinos_Lotaris_Enum  => 2,
                                                                                      SpeziesDatentypen.Carupex_Enum          => 2,
                                                                                      SpeziesDatentypen.Alary_Enum            => 2,
                                                                                      SpeziesDatentypen.Natries_Zermanis_Enum => 2,
                                                                                      SpeziesDatentypen.Tridatus_Enum         => 2,
                                                                                      SpeziesDatentypen.Senelari_Enum         => 2,
                                                                                      SpeziesDatentypen.Aspari_2_Enum         => 2,
                                                                                      SpeziesDatentypen.Ekropa_Enum           => 2,
                                                                                      SpeziesDatentypen.Tesorahn_Enum         => 2,
                                                                                      SpeziesDatentypen.Talbidahr_Enum        => 2
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Festung_Bauen_Enum =>
                                                                                     (
                                                                                      SpeziesDatentypen.Menschen_Enum         => 11,
                                                                                      SpeziesDatentypen.Kasrodiah_Enum        => 11,
                                                                                      SpeziesDatentypen.Lasupin_Enum          => 11,
                                                                                      SpeziesDatentypen.Lamustra_Enum         => 11,
                                                                                      SpeziesDatentypen.Manuky_Enum           => 11,
                                                                                      SpeziesDatentypen.Suroka_Enum           => 11,
                                                                                      SpeziesDatentypen.Pryolon_Enum          => 11,
                                                                                      SpeziesDatentypen.Moru_Phisihl_Enum     => 11,
                                                                                      SpeziesDatentypen.Larinos_Lotaris_Enum  => 11,
                                                                                      SpeziesDatentypen.Carupex_Enum          => 11,
                                                                                      SpeziesDatentypen.Alary_Enum            => 11,
                                                                                      SpeziesDatentypen.Natries_Zermanis_Enum => 11,
                                                                                      SpeziesDatentypen.Tridatus_Enum         => 11,
                                                                                      SpeziesDatentypen.Senelari_Enum         => 11,
                                                                                      SpeziesDatentypen.Aspari_2_Enum         => 11,
                                                                                      SpeziesDatentypen.Ekropa_Enum           => 11,
                                                                                      SpeziesDatentypen.Tesorahn_Enum         => 11,
                                                                                      SpeziesDatentypen.Talbidahr_Enum        => 11
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Roden_Trockenlegen_Enum =>
                                                                                     (
                                                                                      SpeziesDatentypen.Menschen_Enum         => 1,
                                                                                      SpeziesDatentypen.Kasrodiah_Enum        => 1,
                                                                                      SpeziesDatentypen.Lasupin_Enum          => 1,
                                                                                      SpeziesDatentypen.Lamustra_Enum         => 1,
                                                                                      SpeziesDatentypen.Manuky_Enum           => 1,
                                                                                      SpeziesDatentypen.Suroka_Enum           => 1,
                                                                                      SpeziesDatentypen.Pryolon_Enum          => 1,
                                                                                      SpeziesDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                      SpeziesDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                      SpeziesDatentypen.Carupex_Enum          => 1,
                                                                                      SpeziesDatentypen.Alary_Enum            => 1,
                                                                                      SpeziesDatentypen.Natries_Zermanis_Enum => 1,
                                                                                      SpeziesDatentypen.Tridatus_Enum         => 1,
                                                                                      SpeziesDatentypen.Senelari_Enum         => 1,
                                                                                      SpeziesDatentypen.Aspari_2_Enum         => 1,
                                                                                      SpeziesDatentypen.Ekropa_Enum           => 1,
                                                                                      SpeziesDatentypen.Tesorahn_Enum         => 1,
                                                                                      SpeziesDatentypen.Talbidahr_Enum        => 1
                                                                                     )
                                                                                  );
      
   -- Das hier als Standard nehmen und Laden wenn keine Datenbank verfügbar ist, dafür eine Datenbank anlegen. äöü
   type TechnologieWegeArray is array (AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range, SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   StandardtechnologieWege : constant TechnologieWegeArray := (
                                                               AufgabenDatentypen.Straße_Bauen_Enum  =>
                                                                 (
                                                                  SpeziesDatentypen.Menschen_Enum         => 0,
                                                                  SpeziesDatentypen.Kasrodiah_Enum        => 0,
                                                                  SpeziesDatentypen.Lasupin_Enum          => 0,
                                                                  SpeziesDatentypen.Lamustra_Enum         => 0,
                                                                  SpeziesDatentypen.Manuky_Enum           => 0,
                                                                  SpeziesDatentypen.Suroka_Enum           => 0,
                                                                  SpeziesDatentypen.Pryolon_Enum          => 0,
                                                                  SpeziesDatentypen.Moru_Phisihl_Enum     => 0,
                                                                  SpeziesDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                  SpeziesDatentypen.Carupex_Enum          => 0,
                                                                  SpeziesDatentypen.Alary_Enum            => 0,
                                                                  SpeziesDatentypen.Natries_Zermanis_Enum => 0,
                                                                  SpeziesDatentypen.Tridatus_Enum         => 0,
                                                                  SpeziesDatentypen.Senelari_Enum         => 0,
                                                                  SpeziesDatentypen.Aspari_2_Enum         => 0,
                                                                  SpeziesDatentypen.Ekropa_Enum           => 0,
                                                                  SpeziesDatentypen.Tesorahn_Enum         => 0,
                                                                  SpeziesDatentypen.Talbidahr_Enum        => 0
                                                                 ),
                                                                               
                                                               AufgabenDatentypen.Schiene_Bauen_Enum =>
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
                                                                 ),
                                                                               
                                                               AufgabenDatentypen.Tunnel_Bauen_Enum  =>
                                                                 (
                                                                  SpeziesDatentypen.Menschen_Enum         => 20,
                                                                  SpeziesDatentypen.Kasrodiah_Enum        => 20,
                                                                  SpeziesDatentypen.Lasupin_Enum          => 20,
                                                                  SpeziesDatentypen.Lamustra_Enum         => 20,
                                                                  SpeziesDatentypen.Manuky_Enum           => 20,
                                                                  SpeziesDatentypen.Suroka_Enum           => 20,
                                                                  SpeziesDatentypen.Pryolon_Enum          => 20,
                                                                  SpeziesDatentypen.Moru_Phisihl_Enum     => 20,
                                                                  SpeziesDatentypen.Larinos_Lotaris_Enum  => 20,
                                                                  SpeziesDatentypen.Carupex_Enum          => 20,
                                                                  SpeziesDatentypen.Alary_Enum            => 20,
                                                                  SpeziesDatentypen.Natries_Zermanis_Enum => 20,
                                                                  SpeziesDatentypen.Tridatus_Enum         => 20,
                                                                  SpeziesDatentypen.Senelari_Enum         => 20,
                                                                  SpeziesDatentypen.Aspari_2_Enum         => 20,
                                                                  SpeziesDatentypen.Ekropa_Enum           => 20,
                                                                  SpeziesDatentypen.Tesorahn_Enum         => 20,
                                                                  SpeziesDatentypen.Talbidahr_Enum        => 20
                                                                 )
                                                              );
   
   type TechnologieEffektentfernungArray is array (KartengrundDatentypen.Effekt_Kartenfeld_Enum'Range, SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   StandardtechnologieEffektentfernung : constant TechnologieEffektentfernungArray := (
                                                                                       KartengrundDatentypen.Strahlung_Enum =>
                                                                                         (
                                                                                          SpeziesDatentypen.Menschen_Enum         => 0,
                                                                                          SpeziesDatentypen.Kasrodiah_Enum        => 0,
                                                                                          SpeziesDatentypen.Lasupin_Enum          => 0,
                                                                                          SpeziesDatentypen.Lamustra_Enum         => 0,
                                                                                          SpeziesDatentypen.Manuky_Enum           => 0,
                                                                                          SpeziesDatentypen.Suroka_Enum           => 0,
                                                                                          SpeziesDatentypen.Pryolon_Enum          => 0,
                                                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => 0,
                                                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                                          SpeziesDatentypen.Carupex_Enum          => 0,
                                                                                          SpeziesDatentypen.Alary_Enum            => 0,
                                                                                          SpeziesDatentypen.Natries_Zermanis_Enum => 0,
                                                                                          SpeziesDatentypen.Tridatus_Enum         => 0,
                                                                                          SpeziesDatentypen.Senelari_Enum         => 0,
                                                                                          SpeziesDatentypen.Aspari_2_Enum         => 0,
                                                                                          SpeziesDatentypen.Ekropa_Enum           => 0,
                                                                                          SpeziesDatentypen.Tesorahn_Enum         => 0,
                                                                                          SpeziesDatentypen.Talbidahr_Enum        => 0
                                                                                         ),
                                                                                       
                                                                                       KartengrundDatentypen.Biologisch_Enum =>
                                                                                         (
                                                                                          SpeziesDatentypen.Menschen_Enum         => 0,
                                                                                          SpeziesDatentypen.Kasrodiah_Enum        => 0,
                                                                                          SpeziesDatentypen.Lasupin_Enum          => 0,
                                                                                          SpeziesDatentypen.Lamustra_Enum         => 0,
                                                                                          SpeziesDatentypen.Manuky_Enum           => 0,
                                                                                          SpeziesDatentypen.Suroka_Enum           => 0,
                                                                                          SpeziesDatentypen.Pryolon_Enum          => 0,
                                                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => 0,
                                                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                                          SpeziesDatentypen.Carupex_Enum          => 0,
                                                                                          SpeziesDatentypen.Alary_Enum            => 0,
                                                                                          SpeziesDatentypen.Natries_Zermanis_Enum => 0,
                                                                                          SpeziesDatentypen.Tridatus_Enum         => 0,
                                                                                          SpeziesDatentypen.Senelari_Enum         => 0,
                                                                                          SpeziesDatentypen.Aspari_2_Enum         => 0,
                                                                                          SpeziesDatentypen.Ekropa_Enum           => 0,
                                                                                          SpeziesDatentypen.Tesorahn_Enum         => 0,
                                                                                          SpeziesDatentypen.Talbidahr_Enum        => 0
                                                                                         ),
                                                                                       
                                                                                       KartengrundDatentypen.Chemisch_Enum =>
                                                                                         (
                                                                                          SpeziesDatentypen.Menschen_Enum         => 0,
                                                                                          SpeziesDatentypen.Kasrodiah_Enum        => 0,
                                                                                          SpeziesDatentypen.Lasupin_Enum          => 0,
                                                                                          SpeziesDatentypen.Lamustra_Enum         => 0,
                                                                                          SpeziesDatentypen.Manuky_Enum           => 0,
                                                                                          SpeziesDatentypen.Suroka_Enum           => 0,
                                                                                          SpeziesDatentypen.Pryolon_Enum          => 0,
                                                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => 0,
                                                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                                          SpeziesDatentypen.Carupex_Enum          => 0,
                                                                                          SpeziesDatentypen.Alary_Enum            => 0,
                                                                                          SpeziesDatentypen.Natries_Zermanis_Enum => 0,
                                                                                          SpeziesDatentypen.Tridatus_Enum         => 0,
                                                                                          SpeziesDatentypen.Senelari_Enum         => 0,
                                                                                          SpeziesDatentypen.Aspari_2_Enum         => 0,
                                                                                          SpeziesDatentypen.Ekropa_Enum           => 0,
                                                                                          SpeziesDatentypen.Tesorahn_Enum         => 0,
                                                                                          SpeziesDatentypen.Talbidahr_Enum        => 0
                                                                                         ),
                                                                                       
                                                                                       KartengrundDatentypen.Verschmutzt_Enum =>
                                                                                         (
                                                                                          SpeziesDatentypen.Menschen_Enum         => 0,
                                                                                          SpeziesDatentypen.Kasrodiah_Enum        => 0,
                                                                                          SpeziesDatentypen.Lasupin_Enum          => 0,
                                                                                          SpeziesDatentypen.Lamustra_Enum         => 0,
                                                                                          SpeziesDatentypen.Manuky_Enum           => 0,
                                                                                          SpeziesDatentypen.Suroka_Enum           => 0,
                                                                                          SpeziesDatentypen.Pryolon_Enum          => 0,
                                                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => 0,
                                                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                                          SpeziesDatentypen.Carupex_Enum          => 0,
                                                                                          SpeziesDatentypen.Alary_Enum            => 0,
                                                                                          SpeziesDatentypen.Natries_Zermanis_Enum => 0,
                                                                                          SpeziesDatentypen.Tridatus_Enum         => 0,
                                                                                          SpeziesDatentypen.Senelari_Enum         => 0,
                                                                                          SpeziesDatentypen.Aspari_2_Enum         => 0,
                                                                                          SpeziesDatentypen.Ekropa_Enum           => 0,
                                                                                          SpeziesDatentypen.Tesorahn_Enum         => 0,
                                                                                          SpeziesDatentypen.Talbidahr_Enum        => 0
                                                                                         )
                                                                                      );
      
   type TechnologieUmgebungsgrößeArray is array (SystemDatentypen.Anfang_Ende_Enum'Range, SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   StandardtechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                                       SystemDatentypen.Anfangswert_Enum =>
                                                                                         (
                                                                                          SpeziesDatentypen.Menschen_Enum         => 19,
                                                                                          SpeziesDatentypen.Kasrodiah_Enum        => 19,
                                                                                          SpeziesDatentypen.Lasupin_Enum          => 19,
                                                                                          SpeziesDatentypen.Lamustra_Enum         => 19,
                                                                                          SpeziesDatentypen.Manuky_Enum           => 19,
                                                                                          SpeziesDatentypen.Suroka_Enum           => 19,
                                                                                          SpeziesDatentypen.Pryolon_Enum          => 19,
                                                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => 19,
                                                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => 19,
                                                                                          SpeziesDatentypen.Carupex_Enum          => 19,
                                                                                          SpeziesDatentypen.Alary_Enum            => 19,
                                                                                          SpeziesDatentypen.Natries_Zermanis_Enum => 19,
                                                                                          SpeziesDatentypen.Tridatus_Enum         => 19,
                                                                                          SpeziesDatentypen.Senelari_Enum         => 19,
                                                                                          SpeziesDatentypen.Aspari_2_Enum         => 19,
                                                                                          SpeziesDatentypen.Ekropa_Enum           => 19,
                                                                                          SpeziesDatentypen.Tesorahn_Enum         => 19,
                                                                                          SpeziesDatentypen.Talbidahr_Enum        => 19
                                                                                         ),
                                                                               
                                                                                       SystemDatentypen.Endwert_Enum =>
                                                                                         (
                                                                                          SpeziesDatentypen.Menschen_Enum         => 43,
                                                                                          SpeziesDatentypen.Kasrodiah_Enum        => 43,
                                                                                          SpeziesDatentypen.Lasupin_Enum          => 43,
                                                                                          SpeziesDatentypen.Lamustra_Enum         => 43,
                                                                                          SpeziesDatentypen.Manuky_Enum           => 43,
                                                                                          SpeziesDatentypen.Suroka_Enum           => 43,
                                                                                          SpeziesDatentypen.Pryolon_Enum          => 43,
                                                                                          SpeziesDatentypen.Moru_Phisihl_Enum     => 43,
                                                                                          SpeziesDatentypen.Larinos_Lotaris_Enum  => 43,
                                                                                          SpeziesDatentypen.Carupex_Enum          => 43,
                                                                                          SpeziesDatentypen.Alary_Enum            => 43,
                                                                                          SpeziesDatentypen.Natries_Zermanis_Enum => 43,
                                                                                          SpeziesDatentypen.Tridatus_Enum         => 43,
                                                                                          SpeziesDatentypen.Senelari_Enum         => 43,
                                                                                          SpeziesDatentypen.Aspari_2_Enum         => 43,
                                                                                          SpeziesDatentypen.Ekropa_Enum           => 43,
                                                                                          SpeziesDatentypen.Tesorahn_Enum         => 43,
                                                                                          SpeziesDatentypen.Talbidahr_Enum        => 43
                                                                                         )
                                                                                      );

end ForschungRecordKonstanten;
