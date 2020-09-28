with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, WerteFestlegen, Einlesen, GlobaleVariablen, Auswahl, Karten, SchleifenPruefungen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package EinheitenDatenbank is

   type Einheiten is record
      
      -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
      -- Addieren für genaue Passierbarkeit
      
      Anzeige : Wide_Wide_Character;
      
      SiedlerLandeinheitSeeeinheitLufteinheit : Integer; -- 1 = Siedler, 2 = Nahkampfland, 3 = Fernkampfland, 4 = Nahkampfsee, 5 = Fernkampfsee, 6 = Nahkampfluft, 7 = Fernkampfluft
      PreisGeld : Integer;
      PreisRessourcen : Integer;
      Anforderungen : Integer;

      Passierbarkeit : Integer;
      MaximaleLebenspunkte : Integer;
      MaximaleBewegungspunkte : Float;

      Beförderungsgrenze : Integer;
      MaximalerRang : Integer;
      Reichweite : Integer;
      Angriff : Integer;
      Verteidigung : Integer;
      
   end record;

   type EinheitenListeArry is array (1 .. 50) of Einheiten;
   EinheitenListe : constant EinheitenListeArry := (('S', 1, 10, 10, 0,    1, 3, 1.0,    30, 3, 1, 1, 1), -- Siedler

                                                    ('L', 2, 25, 20, 0,    1, 5, 3.0,    30, 3, 1, 3, 1), -- Steinbeilkämpfer
                                                    ('L', 2, 25, 20, 1,    1, 5, 1.0,    30, 3, 1, 3, 1), -- Bogenschütze
                                                    
                                                    ('L', 3, 50, 5, 0,     1, 3, 3.0,    30, 3, 3, 8, 1), -- Kanone

                                                    ('S', 4, 20, 10, 0,    2, 2, 1.0,    30, 3, 1, 1, 1), -- Segelschiff
                                                    ('S', 5, 20, 10, 0,    2, 3, 3.0,    30, 3, 1, 8, 1), -- Kanonenschiff
                                                    
                                                    ('F', 6, 100, 10, 0,   3, 8, 1.0,    30, 3, 1, 10, 1), -- Jäger
                                                    ('F', 7, 100, 10, 0,   3, 8, 1.0,    30, 3, 1, 10, 1), -- Bomber
                                                    
                                                    others => ('@', 0, 0, 0, 0,    0, 0, 0.0,    1, 1, 0, 0, 1));

   procedure Beschreibung (ID : in Integer);
   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse, EinheitNummer : in Integer);
   procedure HeilungBewegungspunkteFürNeueRundeSetzen;
   procedure EinheitErzeugen (Rasse, StadtNummer, ID : in Integer);
   procedure EinheitEntfernen (Sortieren : in Boolean; Rasse, EinheitNummer : in Integer);
   procedure EinheitGebautSortieren (Rasse : in Integer);
   procedure Beschäftigung (Arbeit : in Integer);

   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Integer) return Boolean;

private
   
   Wahl : Integer;
   EinheitenPosition : Integer;
   SortierNummer : Integer;
   
   Heilungsrate : constant Integer := 10;

   type EinheitErstellenRecord is record
      
      YAchse : Integer;
      XAchse : Integer;
      
   end record;

   Position : EinheitErstellenRecord;   

end EinheitenDatenbank;
