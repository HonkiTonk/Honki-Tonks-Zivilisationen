pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

package GrafikRecords is

   type AuswahlTextpositionRecord is record
      
      Auswahl : Natural;
      Textposition : Sf.System.Vector2.sfVector2f;
      
   end record;

end GrafikRecords;
