pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Float_Random;

package ZufallGeneratorenKampf is

   function KampfErfolg
     return Float;

private

   -- Generatoren für KampfErfolg
   ZufälligerFloatWert : Ada.Numerics.Float_Random.Generator;
   -- Generatoren für KampfErfolg

end ZufallGeneratorenKampf;
