pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeVerteidigungskrieg is

   function VerteidigungskriegVorbereiten
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeVerteidigungskrieg;
