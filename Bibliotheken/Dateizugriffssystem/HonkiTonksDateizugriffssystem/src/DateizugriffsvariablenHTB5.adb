package body DateizugriffsvariablenHTB5 is

   procedure DateiformWechseln
     (DateiformExtern : in Character)
   is begin
      
      case
        DateiformExtern
      is
         when 'h' | 'u' | 's' | 'e' | '8' | 'b' =>
            Dateiform (6) := DateiformExtern;
            
         when others =>
            null;
      end case;
      
   end DateiformWechseln;
   
   
   
   function DateiformAbfragen
     return String
   is begin
      
      return Dateiform;
      
   end DateiformAbfragen;

end DateizugriffsvariablenHTB5;
