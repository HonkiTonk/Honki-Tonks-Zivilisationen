pragma SPARK_Mode (On);

with SystemDatentypen;

package OptionenSonstiges is

   function Sonstiges
     return SystemDatentypen.Rückgabe_Werte_Enum;

private
   
   Erfolgreich : Boolean;
   
   AuswahlWert : SystemDatentypen.Rückgabe_Werte_Enum;
   
   EingegebeneZahl : Integer;
   
   procedure AnzahlAutomatischerSpielstände;
   procedure RundenBisAutospeichern;
   procedure SpracheWechseln;

end OptionenSonstiges;
