pragma SPARK_Mode (On);

package OptionenSteuerung is

   function SteuerungBelegen
     return Integer;

private

   NeueTaste : Wide_Wide_Character;

   AuswahlWert : Integer;

end OptionenSteuerung;
