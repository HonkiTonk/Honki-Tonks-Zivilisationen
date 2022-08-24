pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with RueckgabeDatentypen;

private with SystemRecords;

package AuswahlSteuerungsmenue is
   
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
private

   Anfang : constant Positive := 1;
   Ende : Positive;
   
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   AktuelleAuswahl : SystemRecords.MehrfacheAuswahlRecord;
   
   Mausposition : Sf.System.Vector2.sfVector2f;

   function MausAuswahl
     return SystemRecords.MehrfacheAuswahlRecord;
   
end AuswahlSteuerungsmenue;
