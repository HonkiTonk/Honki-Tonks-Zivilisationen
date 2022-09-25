pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabeVerteidigungskriegLogik is

   function VerteidigungskriegVorbereiten
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabeVerteidigungskriegLogik;
