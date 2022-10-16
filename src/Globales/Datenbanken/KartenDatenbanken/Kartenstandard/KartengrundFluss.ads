pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with RassenDatentypen;
with KartendatenbankRecord;

-- Die Flusswerte immer nach Flussarten zuweisen? äöü
-- Sollte ich mich dazu entscheiden jedem Fluss eigene Standardwerte zu geben, dann am besten in Oberfluss, Unterfluss und Lavafluss aufteilen. äöü
package KartengrundFluss is
   
   type KartenflusslisteOberflächeArray is array (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenflusslisteOberfläche : constant KartenflusslisteOberflächeArray := (
                                                                               others =>
                                                                                 (
                                                                                  Bewertung =>
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
   
   type KartenflusslisteUnterflächeArray is array (KartengrundDatentypen.Kartenfluss_Unterfläche_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenflusslisteUnterfläche : constant KartenflusslisteUnterflächeArray := (
                                                                                 others =>
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
   
   type KartenflusslisteKernArray is array (KartengrundDatentypen.Kartenfluss_Kern_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenflusslisteKern : constant KartenflusslisteKernArray := (
                                                                 others =>
                                                                   (
                                                                    Bewertung =>
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

end KartengrundFluss;
