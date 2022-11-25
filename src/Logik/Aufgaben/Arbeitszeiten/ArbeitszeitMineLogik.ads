with ProduktionDatentypen;
with RassenDatentypen;
with KartengrundDatentypen;

package ArbeitszeitMineLogik is
   pragma Preelaborate;
   use type ProduktionDatentypen.Arbeitszeit;

   -- -1 bedeutet es ist unmöglich diese Verbesserung auf diesem Grund anzulegen.
   type BasiszeitArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of ProduktionDatentypen.Arbeitszeit;
   Basiszeit : constant BasiszeitArray := (
                                           RassenDatentypen.Menschen_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Kasrodiah_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Lasupin_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Lamustra_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Manuky_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Suroka_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Pryolon_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Moru_Phisihl_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Larinos_Lotaris_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Carupex_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Alary_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Natries_Zermanis_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Tridatus_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Senelari_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Aspari_2_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Ekropa_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Tesorahn_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             ),

                                           RassenDatentypen.Talbidahr_Enum =>
                                             (
                                              KartengrundDatentypen.Eis_Enum            => 5,
                                              KartengrundDatentypen.Wasser_Enum         => 5,
                                              KartengrundDatentypen.Küstengewässer_Enum => 2,
                                              KartengrundDatentypen.Flachland_Enum      => 2,
                                              KartengrundDatentypen.Wüste_Enum          => 5,
                                              KartengrundDatentypen.Basisgrund_Hügel_Enum'Range          => 3,
                                              KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range        => 5,
                                              KartengrundDatentypen.Tundra_Enum         => 3,
                                              KartengrundDatentypen.Untereis_Enum       => 5,
                                              KartengrundDatentypen.Küstengrund_Enum    => 2,
                                              KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                              KartengrundDatentypen.Erde_Enum           => 2,
                                              KartengrundDatentypen.Erdgestein_Enum     => 2,
                                              KartengrundDatentypen.Sand_Enum           => 2,
                                              KartengrundDatentypen.Gestein_Enum        => 5,
                                              KartengrundDatentypen.Lava_Enum           => -1,
                                              KartengrundDatentypen.Planetenkern_Enum   => -1,
                                              KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                              KartengrundDatentypen.Majorit_Enum        => 2,
                                              KartengrundDatentypen.Perowskit_Enum      => 2,
                                              KartengrundDatentypen.Magnesiowüstit_Enum => 2,
                                              KartengrundDatentypen.Vernichtet_Enum     => -1,
                                              KartengrundDatentypen.Weltraum_Enum       => -1,
                                              KartengrundDatentypen.Wolken_Enum         => -1
                                             )
                                          );



   -- -1 bedeutet es ist unmöglich diese Verbesserung auf diesem Grund anzulegen.
   type ZusatzzeitArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of ProduktionDatentypen.Arbeitszeit;
   Zusatzzeit : constant ZusatzzeitArray := (
                                             RassenDatentypen.Menschen_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Kasrodiah_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Lasupin_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Lamustra_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Manuky_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Suroka_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Pryolon_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Moru_Phisihl_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Larinos_Lotaris_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Carupex_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Alary_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Natries_Zermanis_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Tridatus_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Senelari_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Aspari_2_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Ekropa_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Tesorahn_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               ),

                                             RassenDatentypen.Talbidahr_Enum =>
                                               (
                                                KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                               )
                                            );

end ArbeitszeitMineLogik;
