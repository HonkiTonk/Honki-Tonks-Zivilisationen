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
      
      AktuelleBeschäftigung : Integer;
      AktuelleBeschäftigung2 : Integer;
      
      ID : Integer;
      YAchse : Integer;
      XAchse : Integer;      
      
      AktuelleLebenspunkte : Integer;
      AktuelleBewegungspunkte : Float;
      AktuelleErfahrungspunkte : Integer;
      AktuellerRang : Integer;
      
      AktuelleBeschäftigungszeit : Integer;
      AktuelleBeschäftigungszeit2 : Integer;
      
   end record;

   type EinheitenGebautArray is array (1 .. 18, 1 .. 1000) of EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (1 => (3 => (0, 0,    1, 7, 12,    1, 1.0, 1, 1,    0, 0),
                                              others => (0, 0,     0, 0, 0,     0, 0.0, 0, 0,    0, 0)),
                                              
                                              others => (others => (0, 0,    0, 0, 0,    0, 0.0, 0, 0,    0, 0)));

   type UmgebungBewirtschaftungArray is array (-3 .. 3, -3 .. 3) of Boolean;

   type StadtGebautRecord is record
      
      ID : Integer;
      YAchse : Integer;
      XAchse : Integer;

      AmWasser : Boolean;

      Einwohner : Integer;
      AktuelleNahrungsmittel : Integer;
      AktuelleNahrungsproduktion : Integer;
      AktuelleRessourcen : Integer;
      AktuelleProduktionrate : Integer;
      AktuelleGeldgewinnung : Integer;
      AktuelleForschungsrate : Integer;
      AktuellesBauprojekt : Integer;
      VerbleibendeBauzeit : Integer;
      Korruption : Integer;
      
      GebäudeVorhanden : Wide_Wide_String (1 .. 24);
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : UmgebungBewirtschaftungArray;
      
   end record;
   
   type StadtGebautArray is array (EinheitenGebautArray'Range, 1 .. 100) of StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (1 => (1 => (1, 5, 5,    False,    12, 1, 2, 3, 4, 5, 6, 0, 0, 8,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "Test"),    (others => (others => False))),
                                            2 => (2, 1, 1,    True,    1, 0, 0, 0, 10, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "Mehr"),    (others => (others => False))),
                                            3 => (2, 20, 20,    False,    1, 0, 0, 0, 10, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "Geteste"),    (others => (others => False))),
                                            others => ((0, 0, 0,    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False))))),

                                      2 => (1 => (3, 7, 12,    False,    12, 1, 2, 3, 4, 5, 6, 0, 0, 8,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "TestGegner"),    (others => (others => False))),
                                            2 => (4, 3, 3,    False,    12, 1, 2, 3, 4, 5, 6, 0, 0, 8,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "MehrGegner"),    (others => (others => False))),
                                            others => ((0, 0, 0,    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False))))),
                                      
                                      others => (others => ((0, 0, 0,    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False))))));

   type WichtigesRecord is record
      
      AktuelleGeldmenge : Integer;
      GeldZugewinnProRunde : Integer;
      AktuelleForschungsrate : Integer;
      AktuelleForschungsmenge : Integer;
      AktuellesForschungsprojekt : Integer;

      Erforscht : Wide_Wide_String (1 .. 25);
      
   end record;

   type WichtigesArray is array (EinheitenGebautArray'Range (1)) of WichtigesRecord;
   Wichtiges : WichtigesArray := (others => (0, 0, 0, 0, 1, "0000000000000000000000000"));
   
   type DiplomatieArray is array (EinheitenGebautArray'Range (1), EinheitenGebautArray'Range (1)) of Integer; -- 0 = Kein Kontakt, -1 = Krieg, 1 = Neutral, 2 = Offene Grenzen, 3 = Nichtangriffspakt, 4 = Defensivbündnis, 5 = Offensivbündnis
   Diplomatie : DiplomatieArray := (others => (others => 0));
                                            
end GlobaleVariablen;
