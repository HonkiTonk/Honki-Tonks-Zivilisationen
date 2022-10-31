pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeAngriffskriegLogik is
   pragma Elaborate_Body;

   function AngriffskriegVorbereiten
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeAngriffskriegLogik;
