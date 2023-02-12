package body SpielstandVariablen is
   
   procedure SpielstandnameSchreiben
     (NameExtern : in Unbounded_Wide_Wide_String;
      NummerExtern : in Positive)
   is begin
      
      Spielstand (NummerExtern) := NameExtern;
      
   end SpielstandnameSchreiben;
   
   
   
   function SpielstandnameLesen
     (NummerExtern : in Positive)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spielstand (NummerExtern);
      
   end SpielstandnameLesen;
   
   
   
   function GanzeSpielstandliste
     return SpielstandArray
   is begin
      
      return Spielstand;
      
   end GanzeSpielstandliste;
   
   

   procedure Nullsetzung
   is begin
      
      Spielstand := (others => TextKonstanten.LeerUnboundedString);
      
   end Nullsetzung;

end SpielstandVariablen;
