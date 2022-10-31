pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with AufgabenDatentypen;
with SystemDatentypen;
with BefehleDatentypen;
with ForschungsdatenbankRecord;

package ForschungKonstanten is
   pragma Pure;
   
   LeerKosten : constant ProduktionDatentypen.Einzelproduktion := 0;
   LeerForschung : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
   LeerForschungsanforderung : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
   ForschungUnmöglich : constant ForschungenDatentypen.ForschungIDNichtMöglich := ForschungenDatentypen.ForschungIDNichtMöglich'First;
   
   LeerForschungsliste : constant ForschungsdatenbankRecord.ForschungslisteRecord := (
                                                                                      Kosten      => LeerKosten,
                                                                                      Anforderung => (others => ForschungUnmöglich)
                                                                                     );
   
   -- Das hier als Standard nehmen und Laden wenn keine Datenbank verfügbar ist, dafür eine Datenbank anlegen. äöü
   type TechnologieVerbesserungenArray is array (BefehleDatentypen.Siedler_Verbesserung_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   StandardtechnologieVerbesserungen : constant TechnologieVerbesserungenArray := (
                                                                                   BefehleDatentypen.Straße_Bauen_Enum =>
                                                                                     (
                                                                                      RassenDatentypen.Menschen_Enum         => 0,
                                                                                      RassenDatentypen.Kasrodiah_Enum        => 0,
                                                                                      RassenDatentypen.Lasupin_Enum          => 0,
                                                                                      RassenDatentypen.Lamustra_Enum         => 0,
                                                                                      RassenDatentypen.Manuky_Enum           => 0,
                                                                                      RassenDatentypen.Suroka_Enum           => 0,
                                                                                      RassenDatentypen.Pryolon_Enum          => 0,
                                                                                      RassenDatentypen.Moru_Phisihl_Enum     => 0,
                                                                                      RassenDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                                      RassenDatentypen.Carupex_Enum          => 0,
                                                                                      RassenDatentypen.Alary_Enum            => 0,
                                                                                      RassenDatentypen.Natries_Zermanis_Enum => 0,
                                                                                      RassenDatentypen.Tridatus_Enum         => 0,
                                                                                      RassenDatentypen.Senelari_Enum         => 0,
                                                                                      RassenDatentypen.Aspari_2_Enum         => 0,
                                                                                      RassenDatentypen.Ekropa_Enum           => 0,
                                                                                      RassenDatentypen.Tesorahn_Enum         => 0,
                                                                                      RassenDatentypen.Talbidahr_Enum        => 0
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Wald_Aufforsten_Enum =>
                                                                                     (
                                                                                      RassenDatentypen.Menschen_Enum         => 0,
                                                                                      RassenDatentypen.Kasrodiah_Enum        => 0,
                                                                                      RassenDatentypen.Lasupin_Enum          => 0,
                                                                                      RassenDatentypen.Lamustra_Enum         => 0,
                                                                                      RassenDatentypen.Manuky_Enum           => 0,
                                                                                      RassenDatentypen.Suroka_Enum           => 0,
                                                                                      RassenDatentypen.Pryolon_Enum          => 0,
                                                                                      RassenDatentypen.Moru_Phisihl_Enum     => 0,
                                                                                      RassenDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                                      RassenDatentypen.Carupex_Enum          => 0,
                                                                                      RassenDatentypen.Alary_Enum            => 0,
                                                                                      RassenDatentypen.Natries_Zermanis_Enum => 0,
                                                                                      RassenDatentypen.Tridatus_Enum         => 0,
                                                                                      RassenDatentypen.Senelari_Enum         => 0,
                                                                                      RassenDatentypen.Aspari_2_Enum         => 0,
                                                                                      RassenDatentypen.Ekropa_Enum           => 0,
                                                                                      RassenDatentypen.Tesorahn_Enum         => 0,
                                                                                      RassenDatentypen.Talbidahr_Enum        => 0
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Mine_Bauen_Enum =>
                                                                                     (
                                                                                      RassenDatentypen.Menschen_Enum         => 6,
                                                                                      RassenDatentypen.Kasrodiah_Enum        => 6,
                                                                                      RassenDatentypen.Lasupin_Enum          => 6,
                                                                                      RassenDatentypen.Lamustra_Enum         => 6,
                                                                                      RassenDatentypen.Manuky_Enum           => 6,
                                                                                      RassenDatentypen.Suroka_Enum           => 6,
                                                                                      RassenDatentypen.Pryolon_Enum          => 6,
                                                                                      RassenDatentypen.Moru_Phisihl_Enum     => 6,
                                                                                      RassenDatentypen.Larinos_Lotaris_Enum  => 6,
                                                                                      RassenDatentypen.Carupex_Enum          => 6,
                                                                                      RassenDatentypen.Alary_Enum            => 6,
                                                                                      RassenDatentypen.Natries_Zermanis_Enum => 6,
                                                                                      RassenDatentypen.Tridatus_Enum         => 6,
                                                                                      RassenDatentypen.Senelari_Enum         => 6,
                                                                                      RassenDatentypen.Aspari_2_Enum         => 6,
                                                                                      RassenDatentypen.Ekropa_Enum           => 6,
                                                                                      RassenDatentypen.Tesorahn_Enum         => 6,
                                                                                      RassenDatentypen.Talbidahr_Enum        => 6
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Farm_Bauen_Enum =>
                                                                                     (
                                                                                      RassenDatentypen.Menschen_Enum         => 2,
                                                                                      RassenDatentypen.Kasrodiah_Enum        => 2,
                                                                                      RassenDatentypen.Lasupin_Enum          => 2,
                                                                                      RassenDatentypen.Lamustra_Enum         => 2,
                                                                                      RassenDatentypen.Manuky_Enum           => 2,
                                                                                      RassenDatentypen.Suroka_Enum           => 2,
                                                                                      RassenDatentypen.Pryolon_Enum          => 2,
                                                                                      RassenDatentypen.Moru_Phisihl_Enum     => 2,
                                                                                      RassenDatentypen.Larinos_Lotaris_Enum  => 2,
                                                                                      RassenDatentypen.Carupex_Enum          => 2,
                                                                                      RassenDatentypen.Alary_Enum            => 2,
                                                                                      RassenDatentypen.Natries_Zermanis_Enum => 2,
                                                                                      RassenDatentypen.Tridatus_Enum         => 2,
                                                                                      RassenDatentypen.Senelari_Enum         => 2,
                                                                                      RassenDatentypen.Aspari_2_Enum         => 2,
                                                                                      RassenDatentypen.Ekropa_Enum           => 2,
                                                                                      RassenDatentypen.Tesorahn_Enum         => 2,
                                                                                      RassenDatentypen.Talbidahr_Enum        => 2
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Festung_Bauen_Enum =>
                                                                                     (
                                                                                      RassenDatentypen.Menschen_Enum         => 11,
                                                                                      RassenDatentypen.Kasrodiah_Enum        => 11,
                                                                                      RassenDatentypen.Lasupin_Enum          => 11,
                                                                                      RassenDatentypen.Lamustra_Enum         => 11,
                                                                                      RassenDatentypen.Manuky_Enum           => 11,
                                                                                      RassenDatentypen.Suroka_Enum           => 11,
                                                                                      RassenDatentypen.Pryolon_Enum          => 11,
                                                                                      RassenDatentypen.Moru_Phisihl_Enum     => 11,
                                                                                      RassenDatentypen.Larinos_Lotaris_Enum  => 11,
                                                                                      RassenDatentypen.Carupex_Enum          => 11,
                                                                                      RassenDatentypen.Alary_Enum            => 11,
                                                                                      RassenDatentypen.Natries_Zermanis_Enum => 11,
                                                                                      RassenDatentypen.Tridatus_Enum         => 11,
                                                                                      RassenDatentypen.Senelari_Enum         => 11,
                                                                                      RassenDatentypen.Aspari_2_Enum         => 11,
                                                                                      RassenDatentypen.Ekropa_Enum           => 11,
                                                                                      RassenDatentypen.Tesorahn_Enum         => 11,
                                                                                      RassenDatentypen.Talbidahr_Enum        => 11
                                                                                     ),
                                                                       
                                                                                   BefehleDatentypen.Roden_Trockenlegen_Enum =>
                                                                                     (
                                                                                      RassenDatentypen.Menschen_Enum         => 1,
                                                                                      RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                                      RassenDatentypen.Lasupin_Enum          => 1,
                                                                                      RassenDatentypen.Lamustra_Enum         => 1,
                                                                                      RassenDatentypen.Manuky_Enum           => 1,
                                                                                      RassenDatentypen.Suroka_Enum           => 1,
                                                                                      RassenDatentypen.Pryolon_Enum          => 1,
                                                                                      RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                                      RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                                      RassenDatentypen.Carupex_Enum          => 1,
                                                                                      RassenDatentypen.Alary_Enum            => 1,
                                                                                      RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                                      RassenDatentypen.Tridatus_Enum         => 1,
                                                                                      RassenDatentypen.Senelari_Enum         => 1,
                                                                                      RassenDatentypen.Aspari_2_Enum         => 1,
                                                                                      RassenDatentypen.Ekropa_Enum           => 1,
                                                                                      RassenDatentypen.Tesorahn_Enum         => 1,
                                                                                      RassenDatentypen.Talbidahr_Enum        => 1
                                                                                     )
                                                                                  );
      
   -- Das hier als Standard nehmen und Laden wenn keine Datenbank verfügbar ist, dafür eine Datenbank anlegen. äöü
   type TechnologieWegeArray is array (AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   StandardtechnologieWege : constant TechnologieWegeArray := (
                                                               AufgabenDatentypen.Straße_Bauen_Enum  =>
                                                                 (
                                                                  RassenDatentypen.Menschen_Enum         => 0,
                                                                  RassenDatentypen.Kasrodiah_Enum        => 0,
                                                                  RassenDatentypen.Lasupin_Enum          => 0,
                                                                  RassenDatentypen.Lamustra_Enum         => 0,
                                                                  RassenDatentypen.Manuky_Enum           => 0,
                                                                  RassenDatentypen.Suroka_Enum           => 0,
                                                                  RassenDatentypen.Pryolon_Enum          => 0,
                                                                  RassenDatentypen.Moru_Phisihl_Enum     => 0,
                                                                  RassenDatentypen.Larinos_Lotaris_Enum  => 0,
                                                                  RassenDatentypen.Carupex_Enum          => 0,
                                                                  RassenDatentypen.Alary_Enum            => 0,
                                                                  RassenDatentypen.Natries_Zermanis_Enum => 0,
                                                                  RassenDatentypen.Tridatus_Enum         => 0,
                                                                  RassenDatentypen.Senelari_Enum         => 0,
                                                                  RassenDatentypen.Aspari_2_Enum         => 0,
                                                                  RassenDatentypen.Ekropa_Enum           => 0,
                                                                  RassenDatentypen.Tesorahn_Enum         => 0,
                                                                  RassenDatentypen.Talbidahr_Enum        => 0
                                                                 ),
                                                                               
                                                               AufgabenDatentypen.Schiene_Bauen_Enum =>
                                                                 (
                                                                  RassenDatentypen.Menschen_Enum         => 10,
                                                                  RassenDatentypen.Kasrodiah_Enum        => 10,
                                                                  RassenDatentypen.Lasupin_Enum          => 10,
                                                                  RassenDatentypen.Lamustra_Enum         => 10,
                                                                  RassenDatentypen.Manuky_Enum           => 10,
                                                                  RassenDatentypen.Suroka_Enum           => 10,
                                                                  RassenDatentypen.Pryolon_Enum          => 10,
                                                                  RassenDatentypen.Moru_Phisihl_Enum     => 10,
                                                                  RassenDatentypen.Larinos_Lotaris_Enum  => 10,
                                                                  RassenDatentypen.Carupex_Enum          => 10,
                                                                  RassenDatentypen.Alary_Enum            => 10,
                                                                  RassenDatentypen.Natries_Zermanis_Enum => 10,
                                                                  RassenDatentypen.Tridatus_Enum         => 10,
                                                                  RassenDatentypen.Senelari_Enum         => 10,
                                                                  RassenDatentypen.Aspari_2_Enum         => 10,
                                                                  RassenDatentypen.Ekropa_Enum           => 10,
                                                                  RassenDatentypen.Tesorahn_Enum         => 10,
                                                                  RassenDatentypen.Talbidahr_Enum        => 10
                                                                 ),
                                                                               
                                                               AufgabenDatentypen.Tunnel_Bauen_Enum  =>
                                                                 (
                                                                  RassenDatentypen.Menschen_Enum         => 20,
                                                                  RassenDatentypen.Kasrodiah_Enum        => 20,
                                                                  RassenDatentypen.Lasupin_Enum          => 20,
                                                                  RassenDatentypen.Lamustra_Enum         => 20,
                                                                  RassenDatentypen.Manuky_Enum           => 20,
                                                                  RassenDatentypen.Suroka_Enum           => 20,
                                                                  RassenDatentypen.Pryolon_Enum          => 20,
                                                                  RassenDatentypen.Moru_Phisihl_Enum     => 20,
                                                                  RassenDatentypen.Larinos_Lotaris_Enum  => 20,
                                                                  RassenDatentypen.Carupex_Enum          => 20,
                                                                  RassenDatentypen.Alary_Enum            => 20,
                                                                  RassenDatentypen.Natries_Zermanis_Enum => 20,
                                                                  RassenDatentypen.Tridatus_Enum         => 20,
                                                                  RassenDatentypen.Senelari_Enum         => 20,
                                                                  RassenDatentypen.Aspari_2_Enum         => 20,
                                                                  RassenDatentypen.Ekropa_Enum           => 20,
                                                                  RassenDatentypen.Tesorahn_Enum         => 20,
                                                                  RassenDatentypen.Talbidahr_Enum        => 20
                                                                 )
                                                              );
      
   type TechnologieUmgebungsgrößeArray is array (SystemDatentypen.Anfang_Ende_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   StandardtechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                                       SystemDatentypen.Anfangswert_Enum =>
                                                                                         (
                                                                                          RassenDatentypen.Menschen_Enum         => 19,
                                                                                          RassenDatentypen.Kasrodiah_Enum        => 19,
                                                                                          RassenDatentypen.Lasupin_Enum          => 19,
                                                                                          RassenDatentypen.Lamustra_Enum         => 19,
                                                                                          RassenDatentypen.Manuky_Enum           => 19,
                                                                                          RassenDatentypen.Suroka_Enum           => 19,
                                                                                          RassenDatentypen.Pryolon_Enum          => 19,
                                                                                          RassenDatentypen.Moru_Phisihl_Enum     => 19,
                                                                                          RassenDatentypen.Larinos_Lotaris_Enum  => 19,
                                                                                          RassenDatentypen.Carupex_Enum          => 19,
                                                                                          RassenDatentypen.Alary_Enum            => 19,
                                                                                          RassenDatentypen.Natries_Zermanis_Enum => 19,
                                                                                          RassenDatentypen.Tridatus_Enum         => 19,
                                                                                          RassenDatentypen.Senelari_Enum         => 19,
                                                                                          RassenDatentypen.Aspari_2_Enum         => 19,
                                                                                          RassenDatentypen.Ekropa_Enum           => 19,
                                                                                          RassenDatentypen.Tesorahn_Enum         => 19,
                                                                                          RassenDatentypen.Talbidahr_Enum        => 19
                                                                                         ),
                                                                               
                                                                                       SystemDatentypen.Endwert_Enum =>
                                                                                         (
                                                                                          RassenDatentypen.Menschen_Enum         => 43,
                                                                                          RassenDatentypen.Kasrodiah_Enum        => 43,
                                                                                          RassenDatentypen.Lasupin_Enum          => 43,
                                                                                          RassenDatentypen.Lamustra_Enum         => 43,
                                                                                          RassenDatentypen.Manuky_Enum           => 43,
                                                                                          RassenDatentypen.Suroka_Enum           => 43,
                                                                                          RassenDatentypen.Pryolon_Enum          => 43,
                                                                                          RassenDatentypen.Moru_Phisihl_Enum     => 43,
                                                                                          RassenDatentypen.Larinos_Lotaris_Enum  => 43,
                                                                                          RassenDatentypen.Carupex_Enum          => 43,
                                                                                          RassenDatentypen.Alary_Enum            => 43,
                                                                                          RassenDatentypen.Natries_Zermanis_Enum => 43,
                                                                                          RassenDatentypen.Tridatus_Enum         => 43,
                                                                                          RassenDatentypen.Senelari_Enum         => 43,
                                                                                          RassenDatentypen.Aspari_2_Enum         => 43,
                                                                                          RassenDatentypen.Ekropa_Enum           => 43,
                                                                                          RassenDatentypen.Tesorahn_Enum         => 43,
                                                                                          RassenDatentypen.Talbidahr_Enum        => 43
                                                                                         )
                                                                                      );
   
end ForschungKonstanten;
