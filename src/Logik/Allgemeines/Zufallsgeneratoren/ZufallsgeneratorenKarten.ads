pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Float_Random;

package ZufallsgeneratorenKarten is

   function ZufälligerWert
     return Float;

private

   ZufälligerFloatWert : Ada.Numerics.Float_Random.Generator;

end ZufallsgeneratorenKarten;
