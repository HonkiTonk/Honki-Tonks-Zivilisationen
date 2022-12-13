with Sf.System.Vector2;

private with GrafikRecordKonstanten;

package SeitenleisteLeerenGrafik is
   pragma Elaborate_Body;

   function Leer
     (AnzeigebereichExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),
         
       Post => (
                  Leer'Result.x >= 0.00
                and
                  Leer'Result.y >= 0.00
               );
   
private
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;

end SeitenleisteLeerenGrafik;
