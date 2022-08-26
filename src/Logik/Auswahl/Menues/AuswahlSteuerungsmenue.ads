pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.Window.Keyboard;

with RueckgabeDatentypen;

private with SystemRecords;

package AuswahlSteuerungsmenue is
   
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
private

   Anfang : constant Positive := 1;
   Ende : Positive;
   
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   NeueTaste : Sf.Window.Keyboard.sfKeyCode;

   AktuelleAuswahl : SystemRecords.MehrfacheAuswahlRecord;
      
   procedure TasteBelegen
     (AuswahlExtern : in Positive);
   
end AuswahlSteuerungsmenue;
