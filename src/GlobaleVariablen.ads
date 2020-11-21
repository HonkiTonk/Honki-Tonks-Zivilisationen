with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with Karten, GlobaleDatentypen;

package GlobaleVariablen is

   WelcheSprache : Integer;

   type TexteEinlesenArray is array (1 .. 23, 1 .. 50) of Unbounded_Wide_Wide_String;
   TexteEinlesen : TexteEinlesenArray := (others => (others => (To_Unbounded_Wide_Wide_String ("|"))));

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
   RundenBisAutosave : Integer := 10;

   RassenImSpiel : GlobaleDatentypen.RassenImSpielarray; -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
                                                         -- Ändern das alle RassenBereiche hierauf gehen?

   type EinheitenGebautRecord is record
      
      AktuelleBeschäftigung : Integer;
      AktuelleBeschäftigung2 : Integer;
      
      ID : GlobaleDatentypen.EinheitenID;
      YAchse : Integer;
      XAchse : Integer;      
      
      AktuelleLebenspunkte : Integer;
      AktuelleBewegungspunkte : Float;
      AktuelleErfahrungspunkte : Integer;
      AktuellerRang : Integer;
      
      AktuelleBeschäftigungszeit : Integer;
      AktuelleBeschäftigungszeit2 : Integer;
      
   end record;

   type EinheitenGebautArray is array (RassenImSpiel'Range, 1 .. 1000) of EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => (0, 0,    0, 0, 0,    0, 0.00, 0, 0,    0, 0)));

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
      
      GebäudeVorhanden : Wide_Wide_String (Integer (GlobaleDatentypen.GebäudeID'First) .. Integer (GlobaleDatentypen.GebäudeID'Last)); -- Eine Liste anlegen welche Nummer welches Gebäude ist.
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : UmgebungBewirtschaftungArray;
      ArbeitendeEinwohner : Integer;
      
   end record;
   
   type StadtGebautArray is array (RassenImSpiel'Range, 1 .. 100) of StadtGebautRecord;
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

   type WichtigesArray is array (RassenImSpiel'Range) of WichtigesRecord;
   Wichtiges : WichtigesArray := (others => (0, 0, 0, 0, 10_000, 0, (others => 0)));
   
   type DiplomatieArray is array (RassenImSpiel'Range, RassenImSpiel'Range) of Integer; -- 0 = Kein Kontakt, -1 = Krieg, 1 = Neutral, 2 = Offene Grenzen, 3 = Nichtangriffspakt, 4 = Defensivbündnis, 5 = Offensivbündnis
   Diplomatie : DiplomatieArray := (others => (others => 1));  
                                            
end GlobaleVariablen;
