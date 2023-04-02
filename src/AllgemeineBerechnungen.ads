with ProduktionDatentypen;

-- Soll das hier sein weil ich das auch in anderen Bereichen als in grafik verwenden wollte? äöü
-- Oder ist das einfach nur falsch eingeordnet? äöü
package AllgemeineBerechnungen is
   pragma Preelaborate;
   use type ProduktionDatentypen.Einwohner;

   -- Pre kann hier unter Umständen Probleme bereiten, scheinbar bei der Zerstörung einer Stadt. äöü
   -- Entweder draußen lassen oder Contract anpassen. äöü
   function FreieEinwohner
     (EinwohnerExtern : in ProduktionDatentypen.Einwohner;
      ArbeiterExtern : in ProduktionDatentypen.Einwohner)
      return ProduktionDatentypen.Einwohner;
   -- with
   --   Pre => (
   --             EinwohnerExtern >= ArbeiterExtern
   --          );

end AllgemeineBerechnungen;
