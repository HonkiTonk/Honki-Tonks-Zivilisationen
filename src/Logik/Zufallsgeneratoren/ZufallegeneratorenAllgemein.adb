package body ZufallegeneratorenAllgemein is

   function Münzwurf
     return Boolean
   is begin
      
      Münze.Reset (Gen => GeworfeneMünze);
      return Münze.Random (Gen => GeworfeneMünze);
      
   end Münzwurf;
   
   
   
   function VorgegebenerZahlenbereich
     (AnfangExtern : in Integer;
      EndeExtern : in Integer)
      return Integer
   is begin
      
      if
        AnfangExtern > EndeExtern
      then
         Anfang := EndeExtern;
         Ende := AnfangExtern;
         
      else
         Anfang := AnfangExtern;
         Ende := EndeExtern;
      end if;
      
      Zahlenbereich.Reset (Gen => GewählteZahl);
      return Zahlenbereich.Random (Gen   => GewählteZahl,
                                   First => Anfang,
                                   Last  => Ende);
      
   end VorgegebenerZahlenbereich;

end ZufallegeneratorenAllgemein;
