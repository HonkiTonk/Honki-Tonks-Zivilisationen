pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;

with SchreibeKarten;

with Karten;

package body KartengeneratorWeltraum is

   procedure Weltraum
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop

            SchreibeKarten.Grund (KoordinatenExtern => (2, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartengrundDatentypen.Weltraum_Enum);
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end Weltraum;

end KartengeneratorWeltraum;
