pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeAngriffskriegLogik is

   function AngriffskriegVorbereiten
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeAngriffskriegLogik;
