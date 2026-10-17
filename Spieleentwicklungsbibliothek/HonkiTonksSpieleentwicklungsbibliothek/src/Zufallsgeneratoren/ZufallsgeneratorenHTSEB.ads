private with Ada.Numerics.Discrete_Random;

with SystemDatentypenHTSEB;

private with ZufallsgeneratorenDatentypenHTSEB;

package ZufallsgeneratorenHTSEB is
   pragma Elaborate_Body;

   function Münzwurf
     return Boolean;
   
   function VorgegebenerZahlenbereich
     (AnfangExtern : in Integer;
      EndeExtern : in Integer)
      return Integer;
   
   generic type GanzeZahl is range <>;
   
   function ErreichteErfolge
     (WürfelanzahlExtern : in GanzeZahl)
      return Natural;

   function Hunderterbereich
     return SystemDatentypenHTSEB.NullBisHundert;
   
private
   
   LeerErfolge : constant Natural := 0;
   
   AnzahlErfolge : Integer;
   Anfang : Integer;
   Ende : Integer;
   
   package Münze is new Ada.Numerics.Discrete_Random (Result_Subtype => Boolean);
   
   package Würfel is new Ada.Numerics.Discrete_Random (Result_Subtype => ZufallsgeneratorenDatentypenHTSEB.Bewertung_Enum);
   
   package Hunderter is new Ada.Numerics.Discrete_Random (Result_Subtype => SystemDatentypenHTSEB.NullBisHundert);

   package Zahlenbereich is new Ada.Numerics.Discrete_Random (Result_Subtype => Integer);
   
   GeworfeneMünze : Münze.Generator;
   
   Würfelwurf : Würfel.Generator;
   
   HunderterZahl : Hunderter.Generator;
   
   GewählteZahl : Zahlenbereich.Generator;

end ZufallsgeneratorenHTSEB;
