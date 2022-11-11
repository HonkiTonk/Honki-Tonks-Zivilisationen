with RassenDatentypen;

package Spielertests is
   pragma Elaborate_Body;
   
   function BeliebigeSpielerart
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   return Boolean;

   function MenschlicheSpieler
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
      return Boolean;
   
   function KISpieler
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
      return Boolean;

end Spielertests;
