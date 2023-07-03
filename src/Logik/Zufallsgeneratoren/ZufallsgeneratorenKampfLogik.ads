private with Ada.Numerics.Discrete_Random;

with KampfDatentypen;

private with BewertungDatentypen;

package ZufallsgeneratorenKampfLogik is
   pragma Elaborate_Body;

   function ErreichteErfolge
     (WürfelanzahlExtern : in KampfDatentypen.Kampfwerte)
      return Natural;

private

   LeerErfolge : constant Natural := 0;
   AnzahlErfolge : Integer;

   package Würfel is new Ada.Numerics.Discrete_Random (Result_Subtype => BewertungDatentypen.Bewertung_Enum);

   Würfelwurf : Würfel.Generator;

end ZufallsgeneratorenKampfLogik;
