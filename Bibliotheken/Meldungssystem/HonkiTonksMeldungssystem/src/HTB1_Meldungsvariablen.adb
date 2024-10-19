package body HTB1_Meldungsvariablen is

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

end HTB1_Meldungsvariablen;
