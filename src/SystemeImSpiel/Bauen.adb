package body Bauen is

   procedure Bauen (Rasse, StadtPositionInListe : in Integer) is
   begin
      
      loop
      
         Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (21, 13)));
         -- Auswahl.Auswahl funktioniert hier nicht, da nur baubare Gebäude/Eionheiten angezeigt werden sollen
         -- Kann man aber vielleicht trotzdem Auswahl.Anzeige nutzen?
         
      end loop;
      
   end Bauen;

end Bauen;
