with ProduktionKonstanten;
with SpeziesDatentypen;
with KartenzusatzgrundDatentypen;
with SpeziesArrays;
with KartenbasisgrundDatentypen;

package ArbeitszeitFarmLogik is
   pragma Preelaborate;

   Basiszeit : constant SpeziesArrays.BasiszeitArray := (
                                                         SpeziesDatentypen.Menschen_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Kasrodiah_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Lasupin_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Lamustra_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Manuky_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Suroka_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Pryolon_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Moru_Phisihl_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Larinos_Lotaris_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Carupex_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Alary_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Natries_Zermanis_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Tridatus_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Senelari_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Aspari_2_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Ekropa_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Tesorahn_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           ),

                                                         SpeziesDatentypen.Talbidahr_Enum =>
                                                           (
                                                            KartenbasisgrundDatentypen.Eis_Enum                      => 5,
                                                            KartenbasisgrundDatentypen.Wasser_Enum                   => 5,
                                                            KartenbasisgrundDatentypen.Küstengewässer_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Flachland_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Wüste_Enum                    => 5,
                                                            KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range   => 3,
                                                            KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range => 5,
                                                            KartenbasisgrundDatentypen.Tundra_Enum                   => 3,
                                                            KartenbasisgrundDatentypen.Untereis_Enum                 => 5,
                                                            KartenbasisgrundDatentypen.Küstengrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Meeresgrund_Enum              => 2,
                                                            KartenbasisgrundDatentypen.Erde_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Erdgestein_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Sand_Enum                     => 2,
                                                            KartenbasisgrundDatentypen.Gestein_Enum                  => 5,
                                                            KartenbasisgrundDatentypen.Lava_Enum                     => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Planetenkern_Enum             => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Ringwoodit_Enum               => 2,
                                                            KartenbasisgrundDatentypen.Majorit_Enum                  => 2,
                                                            KartenbasisgrundDatentypen.Perowskit_Enum                => 2,
                                                            KartenbasisgrundDatentypen.Magnesiowüstit_Enum           => 2,
                                                            KartenbasisgrundDatentypen.Vernichtet_Enum               => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Orbit_Enum                 => ProduktionKonstanten.UnmöglicheArbeit,
                                                            KartenbasisgrundDatentypen.Wolken_Enum                   => ProduktionKonstanten.UnmöglicheArbeit
                                                           )
                                                        );



   -- ProduktionKonstanten.UnmöglicheArbeit bedeutet es ist unmöglich diese Verbesserung auf diesem Grund anzulegen.
   Zusatzzeit : constant SpeziesArrays.ZusatzzeitArray := (
                                                           SpeziesDatentypen.Menschen_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Kasrodiah_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Lasupin_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Lamustra_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Manuky_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Suroka_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Pryolon_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Moru_Phisihl_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Larinos_Lotaris_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Carupex_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Alary_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Natries_Zermanis_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Tridatus_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Senelari_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Aspari_2_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Ekropa_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Tesorahn_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             ),

                                                           SpeziesDatentypen.Talbidahr_Enum =>
                                                             (
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum  => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum      => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum   => 3,
                                                              KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum  => 3
                                                             )
                                                          );

end ArbeitszeitFarmLogik;
