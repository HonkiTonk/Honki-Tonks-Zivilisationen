pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;

with SchreibeKarten;

with Karten;
with ZufallsgeneratorenKarten;

package body KartengeneratorPlaneteninneres is

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
               SchreibeKarten.Grund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                     GrundExtern       => KartengrundDatentypen.Planetenkern_Enum);
            
            elsif
              ZufallsgeneratorenKarten.ZufälligerWert > 0.65
            then
               SchreibeKarten.Grund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                     GrundExtern       => KartengrundDatentypen.Lava_Enum);
               
            else
               SchreibeKarten.Grund (KoordinatenExtern => (-2, YAchseSchleifenwert, XAchseSchleifenwert),
                                     GrundExtern       => KartengrundDatentypen.Gestein_Enum);
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
               
   end Planeteninneres;

end KartengeneratorPlaneteninneres;