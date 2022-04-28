pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RueckgabeDatentypen;
with SystemRecords;

package OptionenSonstiges is

   function Sonstiges
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private
   
   Erfolgreich : Boolean;
   
   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   GewählteSprache : Unbounded_Wide_Wide_String;
   
   EingegebeneZahl : SystemRecords.ZahlenEingabeRecord;
   
   procedure AnzahlAutomatischerSpielstände;
   procedure RundenBisAutospeichern;
   procedure SpracheWechseln;

end OptionenSonstiges;