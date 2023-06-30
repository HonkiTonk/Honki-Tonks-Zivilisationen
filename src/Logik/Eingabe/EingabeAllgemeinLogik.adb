with ZeitKonstanten;

with LeseLogiktask;

package body EingabeAllgemeinLogik is

   procedure EingabeAbwarten
   is begin
              
      while LeseLogiktask.WartenGrafik = True loop
         
         delay ZeitKonstanten.WartezeitEingabe;
         
      end loop;
      
   end EingabeAbwarten;

end EingabeAllgemeinLogik;
