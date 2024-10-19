package body HTB3_Umwandlungsvariablen is

   procedure KodierungWechseln
     (KodierungExtern : in Ada.Strings.UTF_Encoding.Encoding_Scheme)
   is begin
      
      Kodierung := KodierungExtern;
      
   end KodierungWechseln;
   
   
   
   procedure TrennzeichenWechseln
     (TrennzeichenExtern : in Wide_Wide_Character)
   is begin
      
      Trennzeichen := TrennzeichenExtern;
      
   end TrennzeichenWechseln;
   
   
   
   function KodierungAbfragen
     return Ada.Strings.UTF_Encoding.Encoding_Scheme
   is begin
      
      return Kodierung;
      
   end KodierungAbfragen;
   
   
   
   function TrennzeichenAbfragen
     return Wide_Wide_Character
   is begin
      
      return Trennzeichen;
      
   end TrennzeichenAbfragen;

end HTB3_Umwandlungsvariablen;
