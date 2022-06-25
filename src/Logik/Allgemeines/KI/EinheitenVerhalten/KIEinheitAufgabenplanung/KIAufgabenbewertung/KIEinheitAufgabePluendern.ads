pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIEinheitAufgabePluendern is

   function StadtUmgebungZerstören
     return KIDatentypen.AufgabenWichtigkeitKlein;

end KIEinheitAufgabePluendern;
