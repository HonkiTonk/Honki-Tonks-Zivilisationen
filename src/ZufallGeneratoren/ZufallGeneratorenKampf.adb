pragma SPARK_Mode (Off);

package body ZufallGeneratorenKampf is

   function KampfErfolg
     return Float
   is begin
      
      Ada.Numerics.Float_Random.Reset (ZufälligerFloatWert);
      GewählterFloatWert := Ada.Numerics.Float_Random.Random (ZufälligerFloatWert);
      
      return GewählterFloatWert;
      
   end KampfErfolg;

end ZufallGeneratorenKampf;
