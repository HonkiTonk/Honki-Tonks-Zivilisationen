package body StandardTastenbelegungDatenbank is

   procedure StandardTastenbelegungLaden
   is begin
            
      AllgemeineBelegung;
      Einheitenbelegung;
      Stadtbelegung;
      
      
   end StandardTastenbelegungLaden;
   
   
   
   procedure AllgemeineBelegung
   is begin
      
      TastenbelegungDatenbank.AllgemeineBelegung := AllgemeineBelegungStandard;
      
   end AllgemeineBelegung;
   
   
   
   procedure Einheitenbelegung
   is begin
      
      TastenbelegungDatenbank.Einheitenbelegung := EinheitenbelegungStandard;
      
   end Einheitenbelegung;
   
   
   
   procedure Stadtbelegung
   is begin
      
      TastenbelegungDatenbank.Stadtbelegung := StadtbelegungStandard;
      
   end Stadtbelegung;

end StandardTastenbelegungDatenbank;
