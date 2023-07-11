with ZeitKonstanten;
with GrafikDatentypen;

with LeseLogiktask;
with SchreibeGrafiktask;

package body EingabeAllgemeinLogik is

   procedure EingabeAbwarten
   is begin
              
      while LeseLogiktask.WartenGrafik = True loop
         
         delay ZeitKonstanten.WartezeitEingabe;
         
      end loop;
      
   end EingabeAbwarten;
   
   
   
   procedure LeerEingabeartFrage
   is begin
      
      -- Reihenfolge hier nicht ändern!
      SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Keine_Eingabe_Enum);
      SchreibeGrafiktask.Fragenanzeige (FrageExtern => 0);
      
   end LeerEingabeartFrage;

end EingabeAllgemeinLogik;
