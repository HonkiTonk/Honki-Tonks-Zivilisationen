with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with Karten, GlobaleDatentypen;

package GlobaleVariablen is

   WelcheSprache : Integer;
   AktuelleEbene : GlobaleDatentypen.Ebene := 0;

   type TexteEinlesenArray is array (1 .. 23, 1 .. 50) of Unbounded_Wide_Wide_String;
   TexteEinlesen : TexteEinlesenArray := (others => (others => (To_Unbounded_Wide_Wide_String ("|"))));

   type CursorRecord is record
      
      CursorGrafik : Wide_Wide_Character;
      YAchse : GlobaleDatentypen.KartenfeldPositiv;
      XAchse : GlobaleDatentypen.KartenfeldPositiv;
      YAchseAlt : GlobaleDatentypen.KartenfeldPositiv;
      XAchseAlt : GlobaleDatentypen.KartenfeldPositiv;
      XAchseStadt : GlobaleDatentypen.Stadtfeld;
      YAchseStadt : GlobaleDatentypen.Stadtfeld;
      
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
      YAchse : GlobaleDatentypen.KartenfeldPositiv;
      XAchse : GlobaleDatentypen.KartenfeldPositiv;      
      
      AktuelleLebenspunkte : Integer;
      AktuelleBewegungspunkte : Float;
      AktuelleErfahrungspunkte : Integer;
      AktuellerRang : Integer;
      
      AktuelleBeschäftigungszeit : Integer;
      AktuelleBeschäftigungszeit2 : Integer;
      
   end record;

   type EinheitenGebautArray is array (RassenImSpiel'Range, 1 .. 1000) of EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => (0, 0,    0, 1, 1,    0, 0.00, 0, 0,    0, 0)));

   type UmgebungBewirtschaftungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of Boolean;

   type StadtGebautRecord is record
      
      ID : Integer;
      YAchse : GlobaleDatentypen.KartenfeldPositiv;
      XAchse : GlobaleDatentypen.KartenfeldPositiv;

      AmWasser : Boolean;

      Einwohner : Integer;
      AktuelleNahrungsmittel : GlobaleDatentypen.KostenLager;
      AktuelleNahrungsproduktion : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleRessourcen : GlobaleDatentypen.KostenLager;
      AktuelleProduktionrate : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleGeldgewinnung : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleForschungsrate : GlobaleDatentypen.GesamtproduktionStadt;
      AktuellesBauprojekt : Integer;
      VerbleibendeBauzeit : GlobaleDatentypen.KostenLager;
      Korruption : GlobaleDatentypen.GesamtproduktionStadt;
      
      GebäudeVorhanden : Wide_Wide_String (Integer (GlobaleDatentypen.GebäudeID'First) .. Integer (GlobaleDatentypen.GebäudeID'Last)); -- Eine Liste anlegen welche Nummer welches Gebäude ist.
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : UmgebungBewirtschaftungArray;
      ArbeitendeEinwohner : Integer;
      StadtUmgebungGröße : GlobaleDatentypen.Stadtfeld;
      
   end record;
   
   type StadtGebautArray is array (RassenImSpiel'Range, 1 .. 100) of StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others =>
                                        (others =>
                                           ((0, 1, 1,    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False)), 0, 1))));

   type ErforschtArray is array (1 .. 6) of Integer;

   type WichtigesRecord is record
      
      AktuelleGeldmenge : Integer;
      GeldZugewinnProRunde : GlobaleDatentypen.KostenLager;
      AktuelleForschungsrate : GlobaleDatentypen.KostenLager;
      AktuelleForschungsmenge : GlobaleDatentypen.KostenLager;
      VerbleibendeForschungszeit : GlobaleDatentypen.KostenLager;
      AktuellesForschungsprojekt : Integer;

      Erforscht : ErforschtArray;
      
   end record;

   type WichtigesArray is array (RassenImSpiel'Range) of WichtigesRecord;
   Wichtiges : WichtigesArray := (others => (0, 0, 0, 0, 10_000, 0, (others => 0)));
   
   type DiplomatieArray is array (RassenImSpiel'Range, RassenImSpiel'Range) of Integer; -- 0 = Kein Kontakt, -1 = Krieg, 1 = Neutral, 2 = Offene Grenzen, 3 = Nichtangriffspakt, 4 = Defensivbündnis, 5 = Offensivbündnis
   Diplomatie : DiplomatieArray := (others => (others => 1));
  
   FeindlicheInformationenSehen : Boolean := False;
                                            
end GlobaleVariablen;
