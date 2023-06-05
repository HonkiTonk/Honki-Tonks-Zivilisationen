with StadtDatentypen;

-- Soll das hier sein weil ich das auch in anderen Bereichen als in Grafik verwenden wollte? äöü
-- Oder ist das einfach nur falsch eingeordnet? äöü
package AllgemeineBerechnungen is
   pragma Preelaborate;
   use type StadtDatentypen.Einwohner;

   function FreieEinwohner
     (EinwohnerExtern : in StadtDatentypen.Einwohner;
      ArbeiterExtern : in StadtDatentypen.Einwohner)
      return StadtDatentypen.Einwohner
    with
      Pre => (
                EinwohnerExtern >= ArbeiterExtern
             );

   generic type GanzeZahl is range <>;

   function Basiszeitwert
     (ZusatzwertExtern : in GanzeZahl;
      TeilerExtern : in GanzeZahl)
      return GanzeZahl
     with
       Pre => (
                 ZusatzwertExtern > 0
               and
                 TeilerExtern > 0
              ),

       Post => (
                  Basiszeitwert'Result > 0
               );

end AllgemeineBerechnungen;
