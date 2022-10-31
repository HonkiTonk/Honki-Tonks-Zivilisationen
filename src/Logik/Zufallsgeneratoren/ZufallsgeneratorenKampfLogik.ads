pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

private with Ada.Numerics.Float_Random;
private with Ada.Numerics.Discrete_Random;

with KampfDatentypen;

private with BewertungDatentypen;

package ZufallsgeneratorenKampfLogik is
   pragma Elaborate_Body;

   function KampfErfolg
     return Float;

   function ErreichteErfolge
     (WürfelanzahlExtern : in KampfDatentypen.KampfwerteAllgemein)
      return Natural;

private

   AnzahlErfolge : Integer;

   package Würfel is new Ada.Numerics.Discrete_Random (Result_Subtype => BewertungDatentypen.Bewertung_Enum);

   Würfelwurf : Würfel.Generator;

   ZufälligerFloatWert : Ada.Numerics.Float_Random.Generator;

end ZufallsgeneratorenKampfLogik;
