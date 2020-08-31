with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Einlesen, GlobaleVariablen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package GebaeudeDatenbank is

   type Gebäude is record
      
      Anzeige : Wide_Wide_Character;
      
      PreisGeld : Integer;      
      PreisRessourcen : Integer;
      Anforderungen : Integer;

   end record;

   type GebäudeListeArray is array (GlobaleVariablen.StadtGebaut (1, 1).GebäudeVorhanden'Range) of Gebäude;
   GebäudeListe : constant GebäudeListeArray := (('B', 100, 100, 10), -- 1 
                                                   ('K', 100, 100, 10), -- 2 
                                                   ('F', 150, 50, 25), -- 3 
                                          
                                                   others => (' ', 0, 0, 0));

   procedure Beschreibung (ID : in Integer);

end GebaeudeDatenbank;
