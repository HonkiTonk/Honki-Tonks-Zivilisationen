pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundKonstanten;

with SchreibeKarten;

with Karten;

package body KartenGeneratorHimmel is

   procedure Himmel
   is begin
               
      YAchseHimmelSchleife:
      for YAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseHimmelSchleife:
         for XAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            SchreibeKarten.Grund (KoordinatenExtern => (1, YAchseHimmelSchleifenwert, XAchseHimmelSchleifenwert),
                                  GrundExtern       => KartenGrundKonstanten.WolkenKonstante);
               
         end loop XAchseHimmelSchleife;
      end loop YAchseHimmelSchleife;
         
   end Himmel;

end KartenGeneratorHimmel;
