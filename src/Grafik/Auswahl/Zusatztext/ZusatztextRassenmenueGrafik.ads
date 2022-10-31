pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

private with RassenDatentypen;

package ZusatztextRassenmenueGrafik is
   pragma Elaborate_Body;

   function ZusatztextRassenmenü
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
                  ZusatztextRassenmenü'Result.x >= 0.00
                and
                  ZusatztextRassenmenü'Result.y >= 0.00
               );

private

   RasseAnzeigen : RassenDatentypen.Rassen_Verwendet_Enum;

   Textposition : Sf.System.Vector2.sfVector2f;

end ZusatztextRassenmenueGrafik;
