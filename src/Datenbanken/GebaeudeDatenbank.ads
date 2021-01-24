with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, Karten, EinheitenDatenbank, EinheitenDatenbank, GlobaleDatentypen;
use GlobaleDatentypen;

package GebaeudeDatenbank is

   type Gebäude is record
      
      Anzeige : Wide_Wide_Character;
      
      PreisGeld : GlobaleDatentypen.KostenLager;      
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      Anforderungen : Integer;

      PermanenteKosten : GlobaleDatentypen.KostenLager;
      ProduktionBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      GeldBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      WissenBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      VerteidigungBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      NahrungBonus : GlobaleDatentypen.GrundwerteNRGWVA;
      Anderes : Boolean;

   end record;

   type GebäudeListeArray is array (GlobaleDatentypen.Rassen'Range, GlobaleVariablen.StadtGebaut (1, 1).GebäudeVorhanden'Range) of Gebäude;
   GebäudeListe : constant GebäudeListeArray := (others => (('B', 100, 100, 0,    0, 0, 0, 0, 0, 0, False), -- 1 
                                                              ('K', 100, 100, 1,    0, 0, 0, 0, 0, 0, False), -- 2 
                                                              ('F', 150, 50, 2,    0, 0, 0, 0, 0, 0, False), -- 3 
                                          
                                                              others => (' ', 0, 0, 0,    0, 0, 0, 0, 0, 0, False)));

   procedure Beschreibung (ID : in Positive);
   
   procedure GebäudeProduktionBeenden (RasseExtern : GlobaleDatentypen.Rassen; StadtNummer, ID : in Positive);

private

   PlatzVorhanden : Boolean;      

end GebaeudeDatenbank;
