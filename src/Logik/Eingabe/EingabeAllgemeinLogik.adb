with Ada.Real_Time; use Ada.Real_Time;

with ZeitKonstanten;

with NachLogiktask;

package body EingabeAllgemeinLogik is

   procedure EingabeAbwarten
   is begin
              
      while NachLogiktask.Warten loop
         
         delay until Clock + ZeitKonstanten.WartezeitEingabe;
         
      end loop;
      
   end EingabeAbwarten;

end EingabeAllgemeinLogik;
