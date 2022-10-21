pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIKonstanten;

package body KIEinheitAufgabeTransporterLogik is

   function AbholungAbwarten
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      return KIKonstanten.UnmöglichAufgabenbewertung;
      
   end AbholungAbwarten;

end KIEinheitAufgabeTransporterLogik;
