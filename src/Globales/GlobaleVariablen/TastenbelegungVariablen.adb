pragma Warnings (Off, "*array aggregate*");

package body TastenbelegungVariablen is
   
   procedure StandardTastenbelegungLaden
   is begin
            
      AllgemeineBelegung := AllgemeineBelegungStandard;
      Einheitenbelegung := EinheitenbelegungStandard;
      Stadtbelegung := StadtbelegungStandard;
      
   end StandardTastenbelegungLaden;

end TastenbelegungVariablen;
