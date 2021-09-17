pragma SPARK_Mode (On);

package OptionenSonstiges is

   function Sonstiges
     return Integer;

private
   
   Erfolgreich : Boolean;
   
   AuswahlWert : Integer;
   
   procedure AnzahlAutomatischerSpielstände;
   procedure RundenBisAutospeichern;
   procedure SpracheWechseln;

end OptionenSonstiges;
