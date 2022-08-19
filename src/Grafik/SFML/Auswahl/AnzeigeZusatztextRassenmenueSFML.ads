pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

private with RassenDatentypen;

package AnzeigeZusatztextRassenmenueSFML is

   procedure AnzeigeZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive);

private

   RasseAnzeigen : RassenDatentypen.Rassen_Verwendet_Enum;

   AnfangsabstandExtratext : constant Float := 5.00;

   PositionHintergrund : Sf.System.Vector2.sfVector2f;

end AnzeigeZusatztextRassenmenueSFML;
