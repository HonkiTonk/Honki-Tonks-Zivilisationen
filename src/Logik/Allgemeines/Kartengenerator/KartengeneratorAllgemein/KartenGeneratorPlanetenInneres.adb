pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen;

with SchreibeKarten;

with Karten;
with ZufallsgeneratorenKarten;

package body KartenGeneratorPlanetenInneres is

   procedure PlanetenInneres
   is begin
      
      YKernanfang := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2 - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 10;
      XKernanfang := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2 - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 10;
      YKernende := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2 + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 10;
      XKernende := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2 + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 10;
               
      YAchseInneresSchleife:
      for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseInneresSchleife:
         for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
            if
              YAchseInneresSchleifenwert in YKernanfang .. YKernende
              and
                XAchseInneresSchleifenwert in XKernanfang .. XKernende
            then
               SchreibeKarten.Grund (KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert),
                                     GrundExtern       => KartenGrundDatentypen.Planetenkern_Enum);
            
            elsif
              ZufallsgeneratorenKarten.ZufälligerWert > 0.65
            then
               SchreibeKarten.Grund (KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert),
                                     GrundExtern       => KartenGrundDatentypen.Lava_Enum);
               
            else
               SchreibeKarten.Grund (KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert),
                                     GrundExtern       => KartenGrundDatentypen.Gestein_Enum);
            end if;
               
         end loop XAchseInneresSchleife;
      end loop YAchseInneresSchleife;
               
   end PlanetenInneres;

end KartenGeneratorPlanetenInneres;
