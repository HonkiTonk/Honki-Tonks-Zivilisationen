pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Color;

with KartengrundDatentypen; use KartengrundDatentypen;

package FarbgebungSFML is

   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Sf.Graphics.Color.sfColor
     with
       Pre =>
         (GrundExtern /= KartengrundDatentypen.Hügel_Mit_Enum);
   
   function FarbeFlussErmitteln
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum)
      return Sf.Graphics.Color.sfColor;
   
private
   
   type FeldfarbeArray is array (KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Range) of Sf.Graphics.Color.sfColor;
   Feldfarbe : constant FeldfarbeArray := (
                                           KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Untereis_Enum                       => (255, 245, 238, 255),
                                           KartengrundDatentypen.Wasser_Enum | KartengrundDatentypen.Meeresgrund_Enum                 => (0, 0, 205, 255),
                                           KartengrundDatentypen.Flachland_Enum                                                       => (100, 160, 60, 255),
                                           KartengrundDatentypen.Tundra_Enum                                                          => (205, 200, 177, 255),
                                           KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Sand_Enum                         => (238, 238, 0, 255),
                                           KartengrundDatentypen.Hügel_Enum                                                           => (205, 133, 63, 255),
                                           KartengrundDatentypen.Gebirge_Enum                                                         => (120, 120, 120, 255),
                                           KartengrundDatentypen.Wald_Enum                                                            => (30, 130, 30, 255),
                                           KartengrundDatentypen.Dschungel_Enum                                                       => (0, 70, 0, 255),
                                           KartengrundDatentypen.Küstengewässer_Enum | KartengrundDatentypen.Küstengrund_Enum => (135, 206, 250, 255),
                                           KartengrundDatentypen.Sumpf_Enum                                                           => (0, 40, 0, 255),
                                           KartengrundDatentypen.Erde_Enum                                                            => (139, 69, 19, 255),
                                           KartengrundDatentypen.Erdgestein_Enum                                                      => (120, 120, 120, 255),
                                           KartengrundDatentypen.Lava_Enum                                                            => (250, 39, 39, 255),
                                           KartengrundDatentypen.Wolken_Enum                                                          => (236, 236, 236, 255),
                                           KartengrundDatentypen.Weltraum_Enum                                                        => (127, 127, 127, 255),
                                           KartengrundDatentypen.Gestein_Enum                                                         => (87, 87, 87, 255),
                                           KartengrundDatentypen.Planetenkern_Enum                                                    => (205, 0, 0, 255),
                                           KartengrundDatentypen.Unterwald_Enum                                                       => (127, 255, 212, 255),
                                           KartengrundDatentypen.Korallen_Enum                                                        => (255, 114, 86, 255),
                                           KartengrundDatentypen.Hügel_Mit_Enum                                                       => (0, 0, 0, 0),
                                           KartengrundDatentypen.Magnesiowüstit_Enum                                                  => (0, 0, 0, 0),
                                           KartengrundDatentypen.Perowskit_Enum                                                       => (0, 0, 0, 0),
                                           KartengrundDatentypen.Majorit_Enum                                                         => (0, 0, 0, 0),
                                           KartengrundDatentypen.Ringwoodit_Enum                                                      => (0, 0, 0, 0),
                                           KartengrundDatentypen.Vernichtet_Enum                                                      => (0, 0, 0, 0)
                                          );
   
   type FlussfarbeArray is array (KartengrundDatentypen.Kartenfluss_Vorhanden_Enum'Range) of Sf.Graphics.Color.sfColor;
   Flussfarbe : constant FlussfarbeArray := (
                                             KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Range | KartengrundDatentypen.Kartenfluss_Unterfläche_Enum'Range => (0, 0, 205, 0),
                                             KartengrundDatentypen.Kartenfluss_Kern_Enum'Range                                                                      => (230, 50, 50, 0)
                                            );

end FarbgebungSFML;
