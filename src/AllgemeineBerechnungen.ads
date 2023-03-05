with ProduktionDatentypen;

package AllgemeineBerechnungen is
   pragma Preelaborate;
   use type ProduktionDatentypen.Einwohner;

   function FreieEinwohner
     (EinwohnerExtern : in ProduktionDatentypen.Einwohner;
      ArbeiterExtern : in ProduktionDatentypen.Einwohner)
      return ProduktionDatentypen.Einwohner
     with
       Pre => (
                 EinwohnerExtern >= ArbeiterExtern
              );

end AllgemeineBerechnungen;
