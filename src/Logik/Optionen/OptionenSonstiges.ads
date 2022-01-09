pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with SystemRecords;

package OptionenSonstiges is

   function Sonstiges
     return SystemDatentypen.Rückgabe_Werte_Enum;

private
   
   Erfolgreich : Boolean;
   
   AuswahlWert : SystemDatentypen.Rückgabe_Werte_Enum;
   
   GewählteSprache : Unbounded_Wide_Wide_String;
   
   EingegebeneZahl : SystemRecords.ZahlenEingabeRecord;
   
   procedure AnzahlAutomatischerSpielstände;
   procedure RundenBisAutospeichern;
   procedure SpracheWechseln;

end OptionenSonstiges;
