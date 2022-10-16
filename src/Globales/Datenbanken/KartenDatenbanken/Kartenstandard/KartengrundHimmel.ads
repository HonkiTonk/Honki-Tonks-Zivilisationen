pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with EinheitenDatentypen;
with RassenDatentypen;
with KartendatenbankRecord;

package KartengrundHimmel is

   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava

   type KartengrundlisteHimmelArray is array (KartengrundDatentypen.Kartengrund_Himmel_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   KartengrundlisteHimmel : constant KartengrundlisteHimmelArray := (
                                                                     KartengrundDatentypen.Wolken_Enum =>
                                                                       (
                                                                        Passierbarkeit => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                           EinheitenDatentypen.Weltraum_Enum => True,
                                                                                           others                            => False),

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

end KartengrundHimmel;
