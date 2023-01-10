with Sf.System.Vector2;

private with SpeziesDatentypen;

package ZusatztextSpeziesmenueGrafik is
   pragma Elaborate_Body;

   function ZusatztextSpeziesmenü
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),

       Post => (
                  ZusatztextSpeziesmenü'Result.x >= 0.00
                and
                  ZusatztextSpeziesmenü'Result.y >= 0.00
               );

private

   SpeziesAnzeigen : SpeziesDatentypen.Spezies_Verwendet_Enum;

   Textposition : Sf.System.Vector2.sfVector2f;

end ZusatztextSpeziesmenueGrafik;
