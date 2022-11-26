with KIVariablen;

package body SchreibeKIVariablen is

   procedure Kriegszustand
     (ZustandExtern : in Boolean)
   is begin
      
      KIVariablen.Kriegszustand := ZustandExtern;
      
   end Kriegszustand;

end SchreibeKIVariablen;
