package body MeldungsvariablenHTB1 is

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

end MeldungsvariablenHTB1;
