with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Einlesen, GlobaleVariablen, Karten, EinheitenDatenbank, EinheitenDatenbank;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package GebaeudeDatenbank is

   type Gebäude is record
      
      Anzeige : Wide_Wide_Character;
      
      PreisGeld : Integer;      
      PreisRessourcen : Integer;
      Anforderungen : Integer;

   end record;

   type GebäudeListeArray is array (GlobaleVariablen.StadtGebaut (1, 1).GebäudeVorhanden'Range) of Gebäude;
   GebäudeListe : constant GebäudeListeArray := (('B', 100, 100, 0), -- 1 
                                                   ('K', 100, 100, 1), -- 2 
                                                   ('F', 150, 50, 2), -- 3 
                                          
                                                   others => (' ', 0, 0, 0));

   procedure Beschreibung (ID : in Integer);
   procedure ProduktionFestlegen (Rasse, Stadtnummer, Produktionsnummer : in Integer);
   procedure ProduktionDurchführen;

private

   PlatzVorhanden : Boolean;
      
   procedure ProduktionBeenden (GebäudeOderEinheit : in Boolean; Rasse, Stadtnummer, Wert : in Integer);

end GebaeudeDatenbank;
