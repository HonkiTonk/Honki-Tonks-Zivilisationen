private with Ada.Numerics.Discrete_Random;

private with HTB6_Datentypen;

package HTB6_Zufallsgeneratoren is

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
   
private
   
   LeerErfolge : constant Natural := 0;
   
   AnzahlErfolge : Integer;
   Anfang : Integer;
   Ende : Integer;
   
   package Münze is new Ada.Numerics.Discrete_Random (Result_Subtype => Boolean);
   
   package Würfel is new Ada.Numerics.Discrete_Random (Result_Subtype => HTB6_Datentypen.Bewertung_Enum);

   package Zahlenbereich is new Ada.Numerics.Discrete_Random (Result_Subtype => Integer);
   
   GeworfeneMünze : Münze.Generator;
   
   Würfelwurf : Würfel.Generator;
   
   GewählteZahl : Zahlenbereich.Generator;

end HTB6_Zufallsgeneratoren;
