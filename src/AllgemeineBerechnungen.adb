package body AllgemeineBerechnungen is

   function FreieEinwohner
     (EinwohnerExtern : in ProduktionDatentypen.Einwohner;
      ArbeiterExtern : in ProduktionDatentypen.Einwohner)
      return ProduktionDatentypen.Einwohner
   is begin
      
      return EinwohnerExtern - ArbeiterExtern;
      
   end FreieEinwohner;
   
   
   
   function Basiszeitwert
     (ZusatzwertExtern : in GanzeZahl;
      TeilerExtern : in GanzeZahl)
      return GanzeZahl
   is begin
      
      return (ZusatzwertExtern + (TeilerExtern - 1)) / TeilerExtern;
      
   end Basiszeitwert;

end AllgemeineBerechnungen;
