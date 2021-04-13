pragma SPARK_Mode (Off);

with Ada.Numerics.Float_Random;

package ZufallGeneratorenKampf is

   function KampfErfolg
     return Float;

private

   -- Generatoren für KampfErfolg
   ZufälligerFloatWert : Ada.Numerics.Float_Random.Generator;
   GewählterFloatWert : Float;
   -- Generatoren für KampfErfolg

end ZufallGeneratorenKampf;
