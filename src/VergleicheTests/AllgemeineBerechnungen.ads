with StadtDatentypen;

package AllgemeineBerechnungen is
   pragma Elaborate_Body;
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
