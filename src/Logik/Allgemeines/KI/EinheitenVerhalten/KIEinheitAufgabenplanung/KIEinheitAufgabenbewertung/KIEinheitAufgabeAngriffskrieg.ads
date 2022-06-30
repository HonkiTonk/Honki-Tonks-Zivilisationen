pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeAngriffskrieg is

   function AngriffskriegVorbereiten
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeAngriffskrieg;
