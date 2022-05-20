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
                                                                                 RassenDatentypen.Menschen_Enum         => 5,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                 RassenDatentypen.Lasupin_Enum          => 5,
                                                                                 RassenDatentypen.Lamustra_Enum         => 3,
                                                                                 RassenDatentypen.Manuky_Enum           => 5,
                                                                                 RassenDatentypen.Suroka_Enum           => 5,
                                                                                 RassenDatentypen.Pryolon_Enum          => 5,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                 RassenDatentypen.Carupex_Enum          => 5,
                                                                                 RassenDatentypen.Alary_Enum            => 3,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                 RassenDatentypen.Tridatus_Enum         => 7,
                                                                                 RassenDatentypen.Senelari_Enum         => 7,
                                                                                 RassenDatentypen.Aspari_2_Enum         => 7,
                                                                                 RassenDatentypen.Ekropa_Enum           => 0,
                                                                                 RassenDatentypen.Tesorahn_Enum         => 0,
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
                                                                                 RassenDatentypen.Menschen_Enum         => 5,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => 7,
                                                                                 RassenDatentypen.Lasupin_Enum          => 5,
                                                                                 RassenDatentypen.Lamustra_Enum         => 5,
                                                                                 RassenDatentypen.Manuky_Enum           => 5,
                                                                                 RassenDatentypen.Suroka_Enum           => 7,
                                                                                 RassenDatentypen.Pryolon_Enum          => 3,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => 7,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                 RassenDatentypen.Carupex_Enum          => 5,
                                                                                 RassenDatentypen.Alary_Enum            => 3,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => 3,
                                                                                 RassenDatentypen.Tridatus_Enum         => 8,
                                                                                 RassenDatentypen.Senelari_Enum         => 0,
                                                                                 RassenDatentypen.Aspari_2_Enum         => 10,
                                                                                 RassenDatentypen.Ekropa_Enum           => 5,
                                                                                 RassenDatentypen.Tesorahn_Enum         => 3,
                                                                                 RassenDatentypen.Talbidahr_Enum        => 5
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
                                                                                 RassenDatentypen.Menschen_Enum         => 5,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                 RassenDatentypen.Lasupin_Enum          => 5,
                                                                                 RassenDatentypen.Lamustra_Enum         => 5,
                                                                                 RassenDatentypen.Manuky_Enum           => 5,
                                                                                 RassenDatentypen.Suroka_Enum           => 5,
                                                                                 RassenDatentypen.Pryolon_Enum          => 5,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                 RassenDatentypen.Carupex_Enum          => 5,
                                                                                 RassenDatentypen.Alary_Enum            => 5,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                 RassenDatentypen.Tridatus_Enum         => 5,
                                                                                 RassenDatentypen.Senelari_Enum         => 5,
                                                                                 RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                 RassenDatentypen.Ekropa_Enum           => 5,
                                                                                 RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                 RassenDatentypen.Talbidahr_Enum        => 5
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
                                                                                 RassenDatentypen.Menschen_Enum         => 5,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                 RassenDatentypen.Lasupin_Enum          => 5,
                                                                                 RassenDatentypen.Lamustra_Enum         => 5,
                                                                                 RassenDatentypen.Manuky_Enum           => 5,
                                                                                 RassenDatentypen.Suroka_Enum           => 5,
                                                                                 RassenDatentypen.Pryolon_Enum          => 5,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                 RassenDatentypen.Carupex_Enum          => 5,
                                                                                 RassenDatentypen.Alary_Enum            => 5,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                 RassenDatentypen.Tridatus_Enum         => 5,
                                                                                 RassenDatentypen.Senelari_Enum         => 5,
                                                                                 RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                 RassenDatentypen.Ekropa_Enum           => 5,
                                                                                 RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                 RassenDatentypen.Talbidahr_Enum        => 5
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
                                                                                 RassenDatentypen.Menschen_Enum         => 5,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                 RassenDatentypen.Lasupin_Enum          => 5,
                                                                                 RassenDatentypen.Lamustra_Enum         => 5,
                                                                                 RassenDatentypen.Manuky_Enum           => 5,
                                                                                 RassenDatentypen.Suroka_Enum           => 5,
                                                                                 RassenDatentypen.Pryolon_Enum          => 5,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                 RassenDatentypen.Carupex_Enum          => 5,
                                                                                 RassenDatentypen.Alary_Enum            => 5,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                 RassenDatentypen.Tridatus_Enum         => 5,
                                                                                 RassenDatentypen.Senelari_Enum         => 5,
                                                                                 RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                 RassenDatentypen.Ekropa_Enum           => 5,
                                                                                 RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                 RassenDatentypen.Talbidahr_Enum        => 5
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
                                                                                 RassenDatentypen.Menschen_Enum         => 5,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                 RassenDatentypen.Lasupin_Enum          => 5,
                                                                                 RassenDatentypen.Lamustra_Enum         => 5,
                                                                                 RassenDatentypen.Manuky_Enum           => 5,
                                                                                 RassenDatentypen.Suroka_Enum           => 5,
                                                                                 RassenDatentypen.Pryolon_Enum          => 5,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                 RassenDatentypen.Carupex_Enum          => 5,
                                                                                 RassenDatentypen.Alary_Enum            => 5,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                 RassenDatentypen.Tridatus_Enum         => 5,
                                                                                 RassenDatentypen.Senelari_Enum         => 5,
                                                                                 RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                 RassenDatentypen.Ekropa_Enum           => 5,
                                                                                 RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                 RassenDatentypen.Talbidahr_Enum        => 5
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
                                                                                 RassenDatentypen.Menschen_Enum         => 5,
                                                                                 RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                                 RassenDatentypen.Lasupin_Enum          => 5,
                                                                                 RassenDatentypen.Lamustra_Enum         => 5,
                                                                                 RassenDatentypen.Manuky_Enum           => 5,
                                                                                 RassenDatentypen.Suroka_Enum           => 5,
                                                                                 RassenDatentypen.Pryolon_Enum          => 5,
                                                                                 RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                                 RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                                 RassenDatentypen.Carupex_Enum          => 5,
                                                                                 RassenDatentypen.Alary_Enum            => 5,
                                                                                 RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                                 RassenDatentypen.Tridatus_Enum         => 5,
                                                                                 RassenDatentypen.Senelari_Enum         => 5,
                                                                                 RassenDatentypen.Aspari_2_Enum         => 5,
                                                                                 RassenDatentypen.Ekropa_Enum           => 5,
                                                                                 RassenDatentypen.Tesorahn_Enum         => 5,
                                                                                 RassenDatentypen.Talbidahr_Enum        => 5
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
