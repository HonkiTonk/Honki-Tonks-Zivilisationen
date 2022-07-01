pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

private with Ada.Numerics.Float_Random;

package ZufallsgeneratorenKampf is

   function KampfErfolg
     return Float;

private

   ZufälligerFloatWert : Ada.Numerics.Float_Random.Generator;

end ZufallsgeneratorenKampf;
