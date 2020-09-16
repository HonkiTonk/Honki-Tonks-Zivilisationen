package body Ausgabe is

   procedure RassenBeschreibung (WelcheRasse : in Integer) is
   begin
      
      null; -- Hier kann der Standardansatz nicht verwendet werden, den einfügen den ich habe, ist in Anzeige
      
   end RassenBeschreibung;
   
   
   
   procedure Zeug (WelchesZeug : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, WelchesZeug)));
      
   end Zeug;



   procedure Fehlermeldungen (WelcheFehlermeldung : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (20, WelcheFehlermeldung)));
      delay 1.5;
      
   end Fehlermeldungen;



   procedure WelcheAuswahl (WasWurdeGewählt : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (21, WasWurdeGewählt)));
      
   end WelcheAuswahl;
   
   
   
   procedure Beschäftigung (WelcheBeschäftigung : in Integer) is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (22, WelcheBeschäftigung)));
      
   end Beschäftigung;

end Ausgabe;
