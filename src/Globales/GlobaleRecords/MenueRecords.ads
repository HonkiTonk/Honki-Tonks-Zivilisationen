pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package MenueRecords is
   
   type MenüRecord is record
      
      Anfang : Positive;
      Endauswahl : Positive;
      
   end record;

end MenueRecords;
