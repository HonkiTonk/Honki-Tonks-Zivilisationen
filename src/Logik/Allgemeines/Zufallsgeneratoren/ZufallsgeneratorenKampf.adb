pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

package body ZufallsgeneratorenKampf is

   function KampfErfolg
     return Float
   is begin
      
      Ada.Numerics.Float_Random.Reset (Gen => ZufälligerFloatWert);
      return Ada.Numerics.Float_Random.Random (Gen => ZufälligerFloatWert);
      
   end KampfErfolg;

end ZufallsgeneratorenKampf;
