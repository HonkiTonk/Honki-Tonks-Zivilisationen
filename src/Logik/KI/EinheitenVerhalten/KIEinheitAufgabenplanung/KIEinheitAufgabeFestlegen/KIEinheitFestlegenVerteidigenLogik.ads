pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KIEinheitFestlegenVerteidigenLogik is
   pragma Elaborate_Body;

   function Verteidigen
     return Boolean;

end KIEinheitFestlegenVerteidigenLogik;
