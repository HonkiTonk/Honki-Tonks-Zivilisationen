private with Ada.Numerics.Discrete_Random;

package ZufallegeneratorenAllgemein is
   pragma Elaborate_Body;

   function Münzwurf
     return Boolean;
   
   function VorgegebenerZahlenbereich
     (AnfangExtern : in Integer;
      EndeExtern : in Integer)
      return Integer;
   
private
   
   Anfang : Integer;
   Ende : Integer;
   
   package Münze is new Ada.Numerics.Discrete_Random (Result_Subtype => Boolean);
   
   package Zahlenbereich is new Ada.Numerics.Discrete_Random (Result_Subtype => Integer);

   GeworfeneMünze : Münze.Generator;
   
   GewählteZahl : Zahlenbereich.Generator;

end ZufallegeneratorenAllgemein;
