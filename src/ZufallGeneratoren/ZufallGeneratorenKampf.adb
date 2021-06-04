pragma SPARK_Mode (Off);

package body ZufallGeneratorenKampf is

   function KampfErfolg
     return Float
   is begin
      
      Ada.Numerics.Float_Random.Reset (ZufälligerFloatWert);
      return Ada.Numerics.Float_Random.Random (ZufälligerFloatWert);
      
   end KampfErfolg;

end ZufallGeneratorenKampf;
