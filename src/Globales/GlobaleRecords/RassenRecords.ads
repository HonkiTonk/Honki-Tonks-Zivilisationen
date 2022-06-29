pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package RassenRecords is

   type RasseRecord is record
      
      Rasse : RassenDatentypen;
      
   end record;

end RassenRecords;
