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
   EinheitenGebaut : EinheitenGebautArray := (2 => (1 => (0, 0,    2, 5, 5,    5, 1.0, 0, 0,    0, 0),
                                                    2 => (0, 0,    2, 10, 10,    5, 1.0, 0, 0,    0, 0),
                                                    3 => (0, 0,    2, 2, 2,    5, 1.0, 0, 0,    0, 0),
                                                    4 => (0, 0,    2, 4, 4,    5, 1.0, 0, 0,    0, 0),
                                                    5 => (0, 0,    2, 15, 15,    5, 1.0, 0, 0,    0, 0),
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
      ArbeitendeEinwohner : Integer;
      
   end record;
   
   type StadtGebautArray is array (EinheitenGebautArray'Range, 1 .. 100) of StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others =>
                                        (others =>
                                           ((0, 0, 0,    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False)), 0))));

   type ErforschtArray is array (1 .. 6) of Integer;

   type WichtigesRecord is record
      
      AktuelleGeldmenge : Integer;
      GeldZugewinnProRunde : Integer;
      AktuelleForschungsrate : Integer;
      AktuelleForschungsmenge : Integer;
      VerbleibendeForschungszeit : Integer;
      AktuellesForschungsprojekt : Integer;

      Erforscht : ErforschtArray;
      
   end record;

   type WichtigesArray is array (EinheitenGebautArray'Range (1)) of WichtigesRecord;
   Wichtiges : WichtigesArray := (others => (0, 0, 0, 0, 10_000, 0, (others => 0)));
   
   type DiplomatieArray is array (EinheitenGebautArray'Range (1), EinheitenGebautArray'Range (1)) of Integer; -- 0 = Kein Kontakt, -1 = Krieg, 1 = Neutral, 2 = Offene Grenzen, 3 = Nichtangriffspakt, 4 = Defensivbündnis, 5 = Offensivbündnis
   Diplomatie : DiplomatieArray := (others => (others => 1));  
                                            
end GlobaleVariablen;
