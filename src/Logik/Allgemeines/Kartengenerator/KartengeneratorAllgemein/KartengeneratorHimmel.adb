pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;

with SchreibeKarten;

with Karten;

package body KartengeneratorHimmel is

   procedure Himmel
   is begin
               
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
            SchreibeKarten.AktuellerGrund (KoordinatenExtern => (1, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartengrundDatentypen.Wolken_Enum);
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
         
   end Himmel;

end KartengeneratorHimmel;
