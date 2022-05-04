pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package InDerStadtBauenKonsole is

   function AuswahlBauprojektKonsole
     return EinheitStadtRecords.BauprojektRecord;

end InDerStadtBauenKonsole;
