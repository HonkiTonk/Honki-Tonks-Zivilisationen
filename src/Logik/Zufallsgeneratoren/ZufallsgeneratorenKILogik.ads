private with Ada.Numerics.Discrete_Random;

package ZufallsgeneratorenKILogik is
   pragma Elaborate_Body;

   function Münzwurf
     return Boolean;
   
private
   
   package Münze is new Ada.Numerics.Discrete_Random (Result_Subtype => Boolean);

   GeworfeneMünze : Münze.Generator;

end ZufallsgeneratorenKILogik;
