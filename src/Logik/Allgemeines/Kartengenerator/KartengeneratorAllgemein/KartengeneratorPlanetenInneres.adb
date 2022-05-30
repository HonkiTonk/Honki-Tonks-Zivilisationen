pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with SchreibeKarten;

with Karten;
with ZufallsgeneratorenKarten;

package body KartengeneratorPlaneteninneres is

   ------------------------ Später eine bessere Generierung einbauen, wie bei der Oberfläche.
   procedure Planeteninneres
   is begin
      
      YKernanfang := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2 - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 10;
      XKernanfang := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2 - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 10;
      YKernende := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2 + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 10;
      XKernende := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2 + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 10;
               
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
            if
              YAchseSchleifenwert in YKernanfang .. YKernende
              and
                XAchseSchleifenwert in XKernanfang .. XKernende
            then
               SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                            GrundExtern       => KartengrundDatentypen.Planetenkern_Enum);
            
            elsif
              ZufallsgeneratorenKarten.KartengeneratorZufallswerte < KartengrundWahrscheinlichkeit (KartengrundDatentypen.Ringwoodit_Enum)
            then
               SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                            GrundExtern       => KartengrundDatentypen.Ringwoodit_Enum);
               
            elsif
              ZufallsgeneratorenKarten.KartengeneratorZufallswerte < KartengrundWahrscheinlichkeit (KartengrundDatentypen.Majorit_Enum)
            then
               SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                            GrundExtern       => KartengrundDatentypen.Majorit_Enum);
               
            elsif
              ZufallsgeneratorenKarten.KartengeneratorZufallswerte < KartengrundWahrscheinlichkeit (KartengrundDatentypen.Perowskit_Enum)
            then
               SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                            GrundExtern       => KartengrundDatentypen.Perowskit_Enum);
               
            elsif
              ZufallsgeneratorenKarten.KartengeneratorZufallswerte < KartengrundWahrscheinlichkeit (KartengrundDatentypen.Magnesiowüstit_Enum)
            then
               SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                            GrundExtern       => KartengrundDatentypen.Magnesiowüstit_Enum);
               
            else
               SchreibeKarten.ZweimalGrund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                            GrundExtern       => KartengrundDatentypen.Lava_Enum);
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
               
   end Planeteninneres;

end KartengeneratorPlaneteninneres;
