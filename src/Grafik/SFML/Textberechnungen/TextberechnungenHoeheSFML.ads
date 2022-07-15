pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package TextberechnungenHoeheSFML is

   function HalbeBildschirmhöhe
     return Float
     with
       Post => (
                  HalbeBildschirmhöhe'Result > 0.00
               );
   
   function KleinerZeilenabstand
     return Float
     with
       Post => (
                  KleinerZeilenabstand'Result > 0.00
               );
   
   function Zeilenabstand
     return Float
     with
       Post => (
                  Zeilenabstand'Result > 0.00
               );
   
   function GroßerZeilenabstand
     return Float
     with
       Post => (
                  GroßerZeilenabstand'Result > 0.00
               );
   
   function Überschriftabstand
     return Float
     with
       Post => (
                  Überschriftabstand'Result > 0.00
               );
   
   function ÜberschriftabstandGroß
     return Float
     with
       Post => (
                  ÜberschriftabstandGroß'Result > 0.00
               );

end TextberechnungenHoeheSFML;
