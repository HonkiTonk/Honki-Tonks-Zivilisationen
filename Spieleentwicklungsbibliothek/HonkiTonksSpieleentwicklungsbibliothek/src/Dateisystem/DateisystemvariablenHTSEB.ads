with BetriebssystemDatentypenHTSEB;

package DateisystemvariablenHTSEB is
   pragma Preelaborate;

   procedure DateiformWechseln
     (DateiformExtern : in Character);
   pragma Inline (DateiformWechseln);
   
   procedure BetriebssystemWechseln
     (BetriebssystemExtern : in BetriebssystemDatentypenHTSEB.Betriebssystem_Enum);
   pragma Inline (BetriebssystemWechseln);
   
   
   
   function DateiformAbfragen
     return String
     with
       Post => (
                  DateiformAbfragen'Result'Length = 6
                and
                  DateiformAbfragen'Result (1 .. 5) = "WCEM="
               );
   pragma Inline (DateiformAbfragen);
   
   function BetriebssystemAbfragen
     return BetriebssystemDatentypenHTSEB.Betriebssystem_Enum;
   pragma Inline (BetriebssystemAbfragen);
   
private
   
   Betriebssystem : BetriebssystemDatentypenHTSEB.Betriebssystem_Enum := BetriebssystemDatentypenHTSEB.Linux_Enum;
   
   Dateiform : String (1 .. 6) := "WCEM=8";

end DateisystemvariablenHTSEB;
