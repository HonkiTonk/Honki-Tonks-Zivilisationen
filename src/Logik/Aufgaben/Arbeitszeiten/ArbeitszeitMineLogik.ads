with ProduktionDatentypen;
with SpeziesDatentypen;
with KartengrundDatentypen;
with SpeziesArrays;

package ArbeitszeitMineLogik is
   pragma Preelaborate;
   use type ProduktionDatentypen.Arbeitszeit;

   -- -1 bedeutet es ist unmöglich diese Verbesserung auf diesem Grund anzulegen.
   Basiszeit : constant SpeziesArrays.BasiszeitArray := (
                                                         SpeziesDatentypen.Menschen_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Kasrodiah_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Lasupin_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Lamustra_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Manuky_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Suroka_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Pryolon_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Moru_Phisihl_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Larinos_Lotaris_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Carupex_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Alary_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Natries_Zermanis_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Tridatus_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Senelari_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Aspari_2_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Ekropa_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Tesorahn_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           ),

                                                         SpeziesDatentypen.Talbidahr_Enum =>
                                                           (
                                                            KartengrundDatentypen.Eis_Enum                      => 5,
                                                            KartengrundDatentypen.Wasser_Enum                   => 5,
                                                            KartengrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartengrundDatentypen.Flachland_Enum                => 2,
                                                            KartengrundDatentypen.Wüste_Enum                    => 5,
                                                            KartengrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartengrundDatentypen.Tundra_Enum                   => 3,
                                                            KartengrundDatentypen.Untereis_Enum                 => 5,
                                                            KartengrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartengrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartengrundDatentypen.Erde_Enum                     => 2,
                                                            KartengrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartengrundDatentypen.Sand_Enum                     => 2,
                                                            KartengrundDatentypen.Gestein_Enum                  => 5,
                                                            KartengrundDatentypen.Lava_Enum                     => -1,
                                                            KartengrundDatentypen.Planetenkern_Enum             => -1,
                                                            KartengrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartengrundDatentypen.Majorit_Enum                  => 2,
                                                            KartengrundDatentypen.Perowskit_Enum                => 2,
                                                            KartengrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartengrundDatentypen.Vernichtet_Enum               => -1,
                                                            KartengrundDatentypen.Weltraum_Enum                 => -1,
                                                            KartengrundDatentypen.Wolken_Enum                   => -1
                                                           )
                                                        );



   -- -1 bedeutet es ist unmöglich diese Verbesserung auf diesem Grund anzulegen.
   Zusatzzeit : constant SpeziesArrays.ZusatzzeitArray := (
                                                           SpeziesDatentypen.Menschen_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Kasrodiah_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Lasupin_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Lamustra_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Manuky_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Suroka_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Pryolon_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Moru_Phisihl_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Larinos_Lotaris_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Carupex_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Alary_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Natries_Zermanis_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Tridatus_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Senelari_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Aspari_2_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Ekropa_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Tesorahn_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Talbidahr_Enum =>
                                                             (
                                                              KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartengrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             )
                                                          );

end ArbeitszeitMineLogik;
