pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package InDerStadtBauenKonsole is

   function AuswahlBauprojektKonsole
     return StadtRecords.BauprojektRecord
     with
       Post =>
         ((if AuswahlBauprojektKonsole'Result.Gebäude /= 0 then AuswahlBauprojektKonsole'Result.Einheit = 0)
          and
            (if AuswahlBauprojektKonsole'Result.Einheit /= 0 then AuswahlBauprojektKonsole'Result.Gebäude = 0));

end InDerStadtBauenKonsole;
