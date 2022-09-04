pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

private with RassenDatentypen;

package ZusatztextRassenmenueGrafik is

   function ZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive;
      AnzeigebereichbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 AnzeigebereichbreiteExtern > 0.00
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