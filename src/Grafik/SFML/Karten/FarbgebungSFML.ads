pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Color;

with KartenGrundDatentypen; use KartenGrundDatentypen;

package FarbgebungSFML is

   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum)
      return Sf.Graphics.Color.sfColor
     with
       Pre =>
         (GrundExtern /= KartenGrundDatentypen.Hügel_Mit_Enum);
   
   function FarbeFlussErmitteln
     (FlussExtern : in KartenGrundDatentypen.Karten_Fluss_Enum)
      return Sf.Graphics.Color.sfColor;
   
private
   
   type FeldfarbeArray is array (KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum'Range) of Sf.Graphics.Color.sfColor;
   Feldfarbe : constant FeldfarbeArray := (
                                            KartenGrundDatentypen.Eis_Enum | KartenGrundDatentypen.Unterwasser_Eis_Enum                       => (255, 245, 238, 255),
                                            KartenGrundDatentypen.Wasser_Enum | KartenGrundDatentypen.Unterwasser_Wasser_Enum                 => (0, 0, 205, 255),
                                            KartenGrundDatentypen.Flachland_Enum                                                              => (100, 160, 60, 255),
                                            KartenGrundDatentypen.Tundra_Enum                                                                 => (205, 200, 177, 255),
                                            KartenGrundDatentypen.Wüste_Enum | KartenGrundDatentypen.Sand_Enum                                => (238, 238, 0, 255),
                                            KartenGrundDatentypen.Hügel_Enum                                                                  => (205, 133, 63, 255),
                                            KartenGrundDatentypen.Gebirge_Enum                                                                => (120, 120, 120, 255),
                                            KartenGrundDatentypen.Wald_Enum                                                                   => (30, 130, 30, 255),
                                            KartenGrundDatentypen.Dschungel_Enum                                                              => (0, 70, 0, 255),
                                            KartenGrundDatentypen.Küstengewässer_Enum | KartenGrundDatentypen.Unterwasser_Küstengewässer_Enum => (135, 206, 250, 255),
                                            KartenGrundDatentypen.Sumpf_Enum                                                                  => (0, 40, 0, 255),
                                            KartenGrundDatentypen.Erde_Enum                                                                   => (139, 69, 19, 255),
                                            KartenGrundDatentypen.Erdgestein_Enum                                                             => (120, 120, 120, 255),
                                            KartenGrundDatentypen.Lava_Enum                                                                   => (250, 39, 39, 255),
                                            KartenGrundDatentypen.Wolken_Enum                                                                 => (236, 236, 236, 255),
                                            KartenGrundDatentypen.Weltraum_Enum                                                               => (127, 127, 127, 255),
                                            KartenGrundDatentypen.Gestein_Enum                                                                => (87, 87, 87, 255),
                                            KartenGrundDatentypen.Planetenkern_Enum                                                           => (205, 0, 0, 255),
                                            KartenGrundDatentypen.Unterwasser_Wald_Enum                                                       => (127, 255, 212, 255),
                                            KartenGrundDatentypen.Korallen_Enum                                                               => (255, 114, 86, 255),
                                            KartenGrundDatentypen.Hügel_Mit_Enum                                                              => (0, 0, 0, 0)
                                           );
   
   type FlussfarbeArray is array (KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum'Range) of Sf.Graphics.Color.sfColor;
   Flussfarbe : constant FlussfarbeArray := (
                                             KartenGrundDatentypen.Karten_Fluss_Vorhanden_Enum'Range | KartenGrundDatentypen.Karten_Unterirdischer_Fluss_Vorhanden_Enum'Range => (0, 0, 205, 0),
                                             KartenGrundDatentypen.Karten_Lavafluss_Vorhanden_Enum'Range                                                                      => (230, 50, 50, 0)
                                            );

end FarbgebungSFML;
