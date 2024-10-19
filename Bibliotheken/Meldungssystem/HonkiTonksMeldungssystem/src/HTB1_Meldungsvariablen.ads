package HTB1_Meldungsvariablen is
   pragma Preelaborate;

   procedure FehlerMeldungWechseln
     (FehlerMeldungExtern : in Boolean);
   pragma  Inline (FehlerMeldungWechseln);
   
   
   
   function FehlerMeldungAbfragen
     return Boolean;
   pragma  Inline (FehlerMeldungAbfragen);
   
private
   
   FehlerMeldung : Boolean := True;

end HTB1_Meldungsvariablen;
