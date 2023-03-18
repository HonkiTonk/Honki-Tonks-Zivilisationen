package body ZufallegeneratorenAllgemein is

   function Münzwurf
     return Boolean
   is begin
      
      Münze.Reset (Gen => GeworfeneMünze);
      return Münze.Random (Gen => GeworfeneMünze);
      
   end Münzwurf;

end ZufallegeneratorenAllgemein;
