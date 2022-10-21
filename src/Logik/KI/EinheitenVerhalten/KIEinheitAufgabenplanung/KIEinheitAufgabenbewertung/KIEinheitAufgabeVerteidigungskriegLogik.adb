pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIKonstanten;

package body KIEinheitAufgabeVerteidigungskriegLogik is

   function VerteidigungskriegVorbereiten
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      return KIKonstanten.UnmöglichAufgabenbewertung;
      
   end VerteidigungskriegVorbereiten;

end KIEinheitAufgabeVerteidigungskriegLogik;
