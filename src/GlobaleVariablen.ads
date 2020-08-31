with Ada.Strings.Wide_Wide_Unbounded, Karten;
use Ada.Strings.Wide_Wide_Unbounded;

package GlobaleVariablen is

   type CursorRecord is record
      
      CursorGrafik : Wide_Wide_Character;
      YAchse : Integer;
      XAchse : Integer;
      YAchseAlt : Integer;
      XAchseAlt : Integer;
      XAchseStadt : Integer;
      YAchseStadt : Integer;
      
   end record;
   
   CursorImSpiel : CursorRecord := ('©', 1, 1, 1, 1, 1, 1);

   SpielerAnzahl : Integer := 1; -- 1 .. 18
   Rasse : Integer := 1; -- 1 .. 18
   RundenAnzahl : Integer := 1;

   type EinheitenGebautRecord is record
      
      AktuelleBeschäftigung : Wide_Wide_Character;
      AktuelleBeschäftigung2 : Wide_Wide_Character;
      
      ID : Integer;
      YAchse : Integer;
      XAchse : Integer;
      AktuelleLebenspunkte : Integer;
      AktuelleBewegungspunkte : Integer;
      AktuelleErfahrungspunkte : Integer;
      AktuellerRang : Integer;
      AktuelleBeschäftigungszeit : Integer;
      AktuelleBeschäftigungszeit2 : Integer;
      
   end record;

   type EinheitenGebautArray is array (1 .. 18, 1 .. 1000) of EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (1 => (4 => ('0', '0', 1, 7, 12, 1, 1, 1, 1, 0, 0),
                                              others => ('0', '0', 0, 0, 0, 0, 0, 0, 0, 0, 0)),
                                              
                                              others => (others => ('0', '0', 0, 0, 0, 0, 0, 0, 0, 0, 0)));

   type StadtGebautRecord is record
      
      ID : Integer;
      YAchse : Integer;
      XAchse : Integer;
      Einwohner : Integer;
      AktuelleNahrungsmittel : Integer;
      AktuelleNahrungsproduktion : Integer;
      AktuelleRessourcen : Integer;
      AktuelleProduktionrate : Integer;
      AktuelleGeldgewinnung : Integer;
      AktuelleForschungsrate : Integer;
      AktuellesBauprojekt : Integer;
      Korruption : Integer;
      GebäudeVorhanden : Wide_Wide_String (1 .. 20);
      Name : Unbounded_Wide_Wide_String;
      
   end record;
   
   type StadtGebautArray is array (EinheitenGebautArray'Range, 1 .. 100) of StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (1 => (1 => (1, 5, 5, 12, 1, 2, 3, 4, 5, 6, 7, 8, "00000000000000000000", To_Unbounded_Wide_Wide_String ("Test")),
                                            2 => (2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, "00000000000000000000", To_Unbounded_Wide_Wide_String ("Mehr")),
                                            3 => (2, 40, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, "00000000000000000000", To_Unbounded_Wide_Wide_String ("Geteste")),
                                            others => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "00000000000000000000", To_Unbounded_Wide_Wide_String (""))),

                                      2 => (1 => (3, 7, 12, 12, 1, 2, 3, 4, 5, 6, 7, 8, "00000000000000000000", To_Unbounded_Wide_Wide_String ("TestGegner")),
                                            2 => (4, 3, 3, 12, 1, 2, 3, 4, 5, 6, 7, 8, "00000000000000000000", To_Unbounded_Wide_Wide_String ("MehrGegner")),
                                            others => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "00000000000000000000", To_Unbounded_Wide_Wide_String (""))),
                                      
                                      others => (others => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "00000000000000000000", To_Unbounded_Wide_Wide_String (""))));

   type VerbesserungenGebautArray is array (Karten.KartenArray'Range (1), Karten.KartenArray'Range (2)) of Integer;
   VerbesserungenGebaut : VerbesserungenGebautArray := (others => (others => 0));

   type GeldRecord is record
      
      AktuelleMenge : Integer;
      ZugewinnProRunde : Integer;
      
   end record;

   type GeldArray is array (EinheitenGebautArray'Range) of GeldRecord;
   Geld : GeldArray := (others => (0, 0));
   
   type DiplomatieArray is array (EinheitenGebautArray'Range, EinheitenGebautArray'Range) of Integer; -- 0 = Kein Kontakt, -1 = Krieg, 1 = Neutral, 2 = Offene Grenzen, 3 = Nichtangriffspakt, 4 = Defensivbündnis, 5 = Offensivbündnis
   Diplomatie : DiplomatieArray := (others => (others => 0));
                                            
end GlobaleVariablen;
