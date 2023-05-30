with SpeziesDatentypen;

package Spielertests is
   pragma Elaborate_Body;
   
   function BeliebigeSpielerart
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
      return Boolean;

   function MenschlicheSpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
      return Boolean;
   
   function KISpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
      return Boolean;

end Spielertests;
