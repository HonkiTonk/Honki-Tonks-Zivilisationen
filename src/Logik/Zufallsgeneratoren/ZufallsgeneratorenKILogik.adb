package body ZufallsgeneratorenKILogik is
   
   function Münzwurf
     return Boolean
   is begin
      
      Münze.Reset (Gen => GeworfeneMünze);
      return Münze.Random (Gen => GeworfeneMünze);
      
   end Münzwurf;
   
end ZufallsgeneratorenKILogik;
