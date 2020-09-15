package body ForschungsDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (16, ID)));
      
   end Beschreibung;



   procedure Forschung is
   begin
      
      null;
      
   end Forschung;

end ForschungsDatenbank;
