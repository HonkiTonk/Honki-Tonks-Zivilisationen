with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, GlobaleVariablen, Karten, EinheitenDatenbank, EinheitenDatenbank;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package GebaeudeDatenbank is

   type Gebäude is record
      
      Anzeige : Wide_Wide_Character;
      
      PreisGeld : Integer;      
      PreisRessourcen : Integer;
      Anforderungen : Integer;

      PermanenteKosten : Integer;
      ProduktionBonus : Integer;
      GeldBonus : Integer;
      WissenBonus : Integer;
      VerteidigungBonus : Integer;
      NahrungBonus : Integer;
      Anderes : Boolean;

   end record;

   type GebäudeListeArray is array (GlobaleVariablen.StadtGebaut (1, 1).GebäudeVorhanden'Range) of Gebäude;
   GebäudeListe : constant GebäudeListeArray := (('B', 100, 100, 0,    0, 0, 0, 0, 0, 0, False), -- 1 
                                                   ('K', 100, 100, 1,    0, 0, 0, 0, 0, 0, False), -- 2 
                                                   ('F', 150, 50, 2,    0, 0, 0, 0, 0, 0, False), -- 3 
                                          
                                                   others => (' ', 0, 0, 0,    0, 0, 0, 0, 0, 0, False));

   procedure Beschreibung (ID : in Integer);
   procedure GebäudeProduktionBeenden (Rasse, StadtNummer, ID : in Integer);
   --procedure InformationenGebäude

private

   PlatzVorhanden : Boolean;      

end GebaeudeDatenbank;
