with KIVariablen;

package body LeseKIVariablen is

   function Kriegszustand
     return Boolean
   is begin
      
      return KIVariablen.Kriegszustand;
      
   end Kriegszustand;

end LeseKIVariablen;
