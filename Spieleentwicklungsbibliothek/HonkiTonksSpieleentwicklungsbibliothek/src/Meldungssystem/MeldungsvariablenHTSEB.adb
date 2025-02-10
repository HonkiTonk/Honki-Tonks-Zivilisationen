package body MeldungsvariablenHTSEB is

   procedure FehlerMeldungWechseln
     (FehlerMeldungExtern : in Boolean)
   is begin
      
      FehlerMeldung := FehlerMeldungExtern;
      
   end FehlerMeldungWechseln;
   
   
   
   function FehlerMeldungAbfragen
     return Boolean
   is begin
      
      return FehlerMeldung;
      
   end FehlerMeldungAbfragen;

end MeldungsvariablenHTSEB;
