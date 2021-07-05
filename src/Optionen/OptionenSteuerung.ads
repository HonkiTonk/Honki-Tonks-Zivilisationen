pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

package OptionenSteuerung is

   function SteuerungBelegen
     return Integer;

private

   NeueAuswahl : GlobaleDatentypen.Tastenbelegung_Enum;

   NeueTaste : Wide_Wide_Character;

   AuswahlWert : Integer;

end OptionenSteuerung;
