package body DateisystemvariablenHTSEB is

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
   
   
   
   procedure BetriebssystemWechseln
     (BetriebssystemExtern : in BetriebssystemDatentypenHTSEB.Betriebssystem_Enum)
   is begin
      
      Betriebssystem := BetriebssystemExtern;
      
   end BetriebssystemWechseln;
   
   
   
   function DateiformAbfragen
     return String
   is begin
      
      return Dateiform;
      
   end DateiformAbfragen;
   
   
   
   function BetriebssystemAbfragen
     return BetriebssystemDatentypenHTSEB.Betriebssystem_Enum
   is begin
      
      return Betriebssystem;
      
   end BetriebssystemAbfragen;

end DateisystemvariablenHTSEB;
