pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KIEinheitFestlegenTransporterLogik is
   pragma Elaborate_Body;

   function AbholungAbwarten
     return Boolean;

end KIEinheitFestlegenTransporterLogik;
