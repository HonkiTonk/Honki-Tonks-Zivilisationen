pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with RassenDatentypen;

with DatenbankRecords;

package KartenressourcenDatenbank is
   
   type KartenRessourcenListeArray is array (KartengrundDatentypen.Karten_Ressourcen_Vorhanden_Enum'Range) of DatenbankRecords.KartenlisteRecord;
   KartenRessourcenListe : KartenRessourcenListeArray;
   
   procedure StandardKartenRessourcenDatenbankLaden;
   
private

   KartenRessourcenListeStandard : constant KartenRessourcenListeArray := (
                                                                           KartengrundDatentypen.Kohle_Enum =>
                                                                             (
                                                                              Bewertung  =>
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
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Eisen_Enum =>
                                                                             (
                                                                              Bewertung  =>
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
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Öl_Enum =>
                                                                             (
                                                                              Bewertung  =>
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
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Fisch_Enum =>
                                                                             (
                                                                              Bewertung  =>
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
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
      
                                                                           KartengrundDatentypen.Wal_Enum =>
                                                                             (
                                                                              Bewertung  =>
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
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Hochwertiger_Boden_Enum =>
                                                                             (
                                                                              Bewertung  =>
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
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Gold_Enum =>
                                                                             (
                                                                              Bewertung  =>
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
                                                                                ),
                                                                              
                                                                                -- Nahrung, Produktion, Geld, Forschung
                                                                              Wirtschaft =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                                ),
                                                                              
                                                                                -- Verteidigung, Angriff
                                                                              Kampf =>
                                                                                (
                                                                                 RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                                 RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                                 RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                                 RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                                 RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                                 RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                                 RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                                 RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                                 RassenDatentypen.Alary_Enum            => (1, 1),
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                                 RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                                 RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                                 RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                                 RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                                 RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                                 RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                                )
                                                                             )
                                                                          );

end KartenressourcenDatenbank;
