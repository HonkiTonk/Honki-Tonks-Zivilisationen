pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;
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
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   
   procedure TasteBelegen
     (AuswahlExtern : in Positive);
   
   

   function MausAuswahl
     return SystemRecords.MehrfacheAuswahlRecord;
   
end AuswahlSteuerungsmenue;
