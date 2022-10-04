pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body TastenbelegungVariablen is
   
   procedure StandardTastenbelegungLaden
   is begin
            
      AllgemeineBelegung := AllgemeineBelegungStandard;
      Einheitenbelegung := EinheitenbelegungStandard;
      
   end StandardTastenbelegungLaden;

end TastenbelegungVariablen;
