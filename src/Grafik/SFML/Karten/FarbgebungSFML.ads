pragma SPARK_Mode (On);

with Sf.Graphics.Color;

with KartenDatentypen; use KartenDatentypen;
with KartenGrundKonstanten;

package FarbgebungSFML is

   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartenDatentypen.Karten_Grund_Alle_Felder_Enum)
      return Sf.Graphics.Color.sfColor
     with
       Pre =>
         (GrundExtern /= KartenGrundKonstanten.HügelMitKonstante);
   
   function FarbeFlussErmitteln
     (FlussExtern : in KartenDatentypen.Karten_Fluss_Enum)
      return Sf.Graphics.Color.sfColor;
   
private
   
   type FeldfarbeArray is array (KartenDatentypen.Karten_Grund_Alle_Felder_Enum'Range) of Sf.Graphics.Color.sfColor;
   Feldfarbe : FeldfarbeArray := ( -----------------------------
                                   KartenGrundKonstanten.EisKonstante | KartenGrundKonstanten.UnterwasserEisKonstante => (255, 245, 238, 255),
                                   KartenGrundKonstanten.WasserKonstante | KartenGrundKonstanten.UnterwasserWasserKonstante => (0, 0, 205, 255),
                                   KartenGrundKonstanten.FlachlandKonstante => (100, 160, 60, 255),
                                   KartenGrundKonstanten.TundraKonstante => (205, 200, 177, 255),
                                   KartenGrundKonstanten.WüsteKonstante | KartenGrundKonstanten.SandKonstante => (238, 238, 0, 255),
                                   KartenGrundKonstanten.HügelKonstante => (205, 133, 63, 255),
                                   KartenGrundKonstanten.GebirgeKonstante => (120, 120, 120, 255),
                                   KartenGrundKonstanten.WaldKonstante => (30, 130, 30, 255),
                                   KartenGrundKonstanten.DschungelKonstante => (0, 70, 0, 255),
                                   KartenGrundKonstanten.KüstengewässerKonstante | KartenGrundKonstanten.UnterwasserKüstengewässerKonstante => (135, 206, 250, 255),
                                   KartenGrundKonstanten.SumpfKonstante => (0, 40, 0, 255),
                                   KartenGrundKonstanten.ErdeKonstante => (139, 69, 19, 255),
                                   KartenGrundKonstanten.ErdgesteinKonstante => (120, 120, 120, 255),
                                   KartenGrundKonstanten.LavaKonstante => (250, 39, 39, 255),
                                   KartenGrundKonstanten.WolkenKonstante => (236, 236, 236, 255),
                                   KartenGrundKonstanten.WeltraumKonstante => (127, 127, 127, 255),
                                   KartenGrundKonstanten.GesteinKonstante => (87, 87, 87, 255),
                                   KartenGrundKonstanten.PlanetenkernKonstante => (205, 0, 0, 255),
                                   KartenGrundKonstanten.UnterwasserWaldKonstante => (127, 255, 212, 255),
                                   KartenGrundKonstanten.KorallenKonstante => (255, 114, 86, 255),
                                   KartenGrundKonstanten.HügelMitKonstante => (0, 0, 0, 0)
                                  );
   
   type FlussfarbeArray is array (KartenDatentypen.Karten_Fluss_Enum'Range) of Sf.Graphics.Color.sfColor;
   Flussfarbe : FlussfarbeArray := (
                                    KartenDatentypen.Karten_Grund_Fluss_Enum'Range | KartenDatentypen.Karten_Grund_Unterirdischer_Fluss_Enum'Range => (0, 0, 205, 0),
                                    KartenDatentypen.Karten_Grund_Lavafluss_Enum'Range                                                             => (230, 50, 50, 0)
                                   );

end FarbgebungSFML;
