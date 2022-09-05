pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ZeitKonstanten;

with NachLogiktask;

package body EingabeAllgemeinLogik is

   procedure EingabeAbwarten
   is begin
              
      while NachLogiktask.Warten loop
         
         delay ZeitKonstanten.WartezeitEingabe;
         
      end loop;
      
   end EingabeAbwarten;

end EingabeAllgemeinLogik;
