-- Ds hier später auch wie die Anderen Variablen in Schreibe/Leseteile aufteilen? äöü
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
     return ArraysHTSEB.SetsArray
   is begin
      
      return Spielstand;
      
   end GanzeSpielstandliste;
   
   

   procedure Nullsetzung
   is begin
      
      Spielstand := (others => TextKonstantenHTSEB.LeerUnboundedString);
      
   end Nullsetzung;
   
   
   
   procedure SpielstandartSchreiben
     (SpielstandartExtern : in SystemDatentypenHTSEB.Spielstand_Enum)
   is begin
      
      Spielstandart := SpielstandartExtern;
      
   end SpielstandartSchreiben;
   
   
   
   function SpielstandartLesen
     return SystemDatentypenHTSEB.Spielstand_Enum
   is begin
      
      return Spielstandart;
      
   end SpielstandartLesen;

end SpielstandVariablen;
