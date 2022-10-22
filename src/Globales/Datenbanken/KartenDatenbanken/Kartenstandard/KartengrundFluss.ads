pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with RassenDatentypen;
with KartendatenbankRecord;

with KIBewertungDatentypen;

-- Die Flusswerte immer nach Flussarten zuweisen? äöü
-- Sollte ich mich dazu entscheiden jedem Fluss eigene Standardwerte zu geben, dann am besten in Oberfluss, Unterfluss und Lavafluss aufteilen. äöü
package KartengrundFluss is
   
   type KartenflusslisteOberflächeArray is array (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   KartenflusslisteOberfläche : constant KartenflusslisteOberflächeArray := (
                                                                               others =>
                                                                                 (
                                                                                  Bewertung =>
                                                                                    (
                                                                                     RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                     RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum
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
                                                                                       RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                                       RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum
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
                                                                       RassenDatentypen.Menschen_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Kasrodiah_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Lasupin_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Lamustra_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Manuky_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Suroka_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Pryolon_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Carupex_Enum          => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Alary_Enum            => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Natries_Zermanis_Enum => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Tridatus_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Senelari_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Aspari_2_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Ekropa_Enum           => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Tesorahn_Enum         => KIBewertungDatentypen.Bewertung_Fünf_Enum,
                                                                       RassenDatentypen.Talbidahr_Enum        => KIBewertungDatentypen.Bewertung_Fünf_Enum
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
