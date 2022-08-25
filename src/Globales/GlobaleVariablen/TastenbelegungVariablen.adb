pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body TastenbelegungVariablen is
   
   procedure StandardTastenbelegungLaden
   is begin
      
      Tastenbelegung := TastenbelegungStandard;
      
   end StandardTastenbelegungLaden;

end TastenbelegungVariablen;
