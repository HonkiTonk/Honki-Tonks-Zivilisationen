pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package InDerStadtBauenKonsole is

   function AuswahlBauprojektKonsole
     return StadtRecords.BauprojektRecord;

end InDerStadtBauenKonsole;
