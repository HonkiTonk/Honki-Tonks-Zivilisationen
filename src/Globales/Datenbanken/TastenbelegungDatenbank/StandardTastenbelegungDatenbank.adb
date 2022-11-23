with TastenbelegungDatenbank;

with TastenbelegungStandard;

package body StandardTastenbelegungDatenbank is

   -- Später so aufteilen das man die Steuerung auch einzeln zurück auf den Standard setzen kann? äöü
   procedure StandardTastenbelegungLaden
   is begin
            
      TastenbelegungDatenbank.AllgemeineBelegung := TastenbelegungStandard.AllgemeineBelegungStandard;
      TastenbelegungDatenbank.Einheitenbelegung := TastenbelegungStandard.EinheitenbelegungStandard;
      TastenbelegungDatenbank.Stadtbelegung := TastenbelegungStandard.StadtbelegungStandard;
      
   end StandardTastenbelegungLaden;

end StandardTastenbelegungDatenbank;
