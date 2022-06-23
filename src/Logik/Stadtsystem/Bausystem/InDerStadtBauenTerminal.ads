pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package InDerStadtBauenTerminal is

   function AuswahlBauprojektTerminal
     return StadtRecords.BauprojektRecord
     with
       Post => (
                  if AuswahlBauprojektTerminal'Result.Gebäude /= 0 then AuswahlBauprojektTerminal'Result.Einheit = 0
                and
                  if AuswahlBauprojektTerminal'Result.Einheit /= 0 then AuswahlBauprojektTerminal'Result.Gebäude = 0
               );

end InDerStadtBauenTerminal;
