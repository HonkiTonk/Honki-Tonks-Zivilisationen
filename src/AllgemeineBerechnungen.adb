package body AllgemeineBerechnungen is

   function FreieEinwohner
     (EinwohnerExtern : in ProduktionDatentypen.Einwohner;
      ArbeiterExtern : in ProduktionDatentypen.Einwohner)
      return ProduktionDatentypen.Einwohner
   is begin
      
      return EinwohnerExtern - ArbeiterExtern;
      
   end FreieEinwohner;

end AllgemeineBerechnungen;
