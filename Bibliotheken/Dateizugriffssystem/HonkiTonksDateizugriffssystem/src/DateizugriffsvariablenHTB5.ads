package DateizugriffsvariablenHTB5 is
   pragma Preelaborate;

   procedure DateiformWechseln
     (DateiformExtern : in Character);
   
   function DateiformAbfragen
     return String
     with
       Post => (
                  DateiformAbfragen'Result'Length = 6
                and
                  DateiformAbfragen'Result (1 .. 5) = "WCEM="
               );
   
private
   
   Dateiform : String (1 .. 6) := "WCEM=8";

end DateizugriffsvariablenHTB5;
