with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, Auswahl, Karten, SchleifenPruefungen, GlobaleDatentypen;
use GlobaleDatentypen;

package EinheitenDatenbank is

   type Einheiten is record
      
      -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
      -- Addieren für genaue Passierbarkeit
      
      Anzeige : Wide_Wide_Character;
      
      SiedlerLandeinheitSeeeinheitLufteinheit : Integer; -- 1 = Siedler, 2 = Bauarbeiter, 3 = Nahkampfland, 4 = Fernkampfland, 5 = Nahkampfsee, 6 = Fernkampfsee, 7 = Nahkampfluft, 8 = Fernkampfluft
      PreisGeld : GlobaleDatentypen.KostenLager;
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      Anforderungen : Integer;

      Passierbarkeit : GlobaleDatentypen.PassierbarkeitType;
      MaximaleLebenspunkte : Integer;
      MaximaleBewegungspunkte : Float;

      Beförderungsgrenze : Integer;
      MaximalerRang : Integer;
      Reichweite : Integer;
      Angriff : GlobaleDatentypen.GrundwerteNRGWVA;
      Verteidigung : GlobaleDatentypen.GrundwerteNRGWVA;
      
   end record;

   type EinheitenListeArry is array (GlobaleDatentypen.RassenImSpielArray'Range, 1 .. GlobaleDatentypen.EinheitenID'Last) of Einheiten;
   EinheitenListe : constant EinheitenListeArry := (others => (('S', 1, 10, 10, 0,    1, 3, 1.00,    30, 3, 1, 1, 1), -- Siedler

                                                               ('L', 2, 25, 20, 0,    1, 5, 3.00,    30, 3, 1, 3, 1), -- Steinbeilkämpfer
                                                               ('L', 2, 25, 20, 1,    1, 5, 1.00,    30, 3, 1, 3, 1), -- Bogenschütze
                                                    
                                                               ('L', 3, 50, 5, 0,     1, 3, 3.00,    30, 3, 3, 8, 1), -- Kanone

                                                               ('S', 4, 20, 10, 0,    2, 2, 1.00,    30, 3, 1, 1, 1), -- Segelschiff
                                                               ('S', 5, 20, 10, 0,    2, 3, 3.00,    30, 3, 1, 8, 1), -- Kanonenschiff
                                                    
                                                               ('F', 6, 100, 10, 0,   3, 8, 1.00,    30, 3, 1, 10, 1), -- Jäger
                                                               ('F', 7, 100, 10, 0,   3, 8, 1.00,    30, 3, 1, 10, 1), -- Bomber
                                                    
                                                               others => ('@', 0, 0, 0, 0,    1, 0, 0.00,    1, 1, 0, 0, 1)));

   procedure Beschreibung (ID : in GlobaleDatentypen.EinheitenID);
   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse, EinheitNummer : in Integer);
   procedure HeilungBewegungspunkteFürNeueRundeSetzen;
   procedure EinheitErzeugen (Rasse, StadtNummer, ID : in Integer);
   procedure EinheitEntfernen (Rasse, EinheitNummer : in Integer);
   procedure EinheitGebautSortieren (Rasse : in Integer);
   procedure Beschäftigung (Arbeit : in Integer);

   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Integer) return Boolean;

private
   
   Wahl : Integer;
   EinheitenPosition : Integer;
   SortierNummer : Integer;
   
   Heilungsrate : constant Integer := 10;

   type EinheitErstellenRecord is record
      
      EAchse : GlobaleDatentypen.Ebene;
      YAchse : GlobaleDatentypen.KartenfeldPositiv;
      XAchse : GlobaleDatentypen.KartenfeldPositiv;
      
   end record;

   Position : EinheitErstellenRecord;
   
   type SortierenArray is array (GlobaleVariablen.EinheitenGebautArray'Range (2)) of GlobaleVariablen.EinheitenGebautRecord;
   Sortieren : SortierenArray;

end EinheitenDatenbank;
