with Sf.Graphics.Rect;

package ViewbereicheBerechnenGrafik is
   pragma Elaborate_Body;

   function ViewbereichBreiteHöheBerechnen
     (BereichExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Sf.Graphics.Rect.sfFloatRect
     with
       Pre => (
                 BereichExtern.left >= 0.00
               and
                 BereichExtern.top >= 0.00
               and
                 BereichExtern.width >= 0.00
               and
                 BereichExtern.height >= 0.00
              ),
         
       Post => (
                  ViewbereichBreiteHöheBerechnen'Result.left >= 0.00
                and
                  ViewbereichBreiteHöheBerechnen'Result.top >= 0.00
                and
                  ViewbereichBreiteHöheBerechnen'Result.width >= 0.00
                and
                  ViewbereichBreiteHöheBerechnen'Result.height >= 0.00
               );
   
private
   
   NeuerBereich : Sf.Graphics.Rect.sfFloatRect;

end ViewbereicheBerechnenGrafik;
