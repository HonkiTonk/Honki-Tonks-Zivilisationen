with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, Auswahl, Karten, SchleifenPruefungen, GlobaleDatentypen, GlobaleRecords, Anzeige;
use GlobaleDatentypen, GlobaleRecords;

package EinheitenDatenbank is

   type Einheiten is record
      
      -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
      -- Addieren für genaue Passierbarkeit
      
      Anzeige : Wide_Wide_Character;
      
      SiedlerLandeinheitSeeeinheitLufteinheit : Integer; -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft
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

   type EinheitenListeArry is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.EinheitenID'Range) of Einheiten;
   EinheitenListe : constant EinheitenListeArry := (others => (('S', 1, 10, 10, 0,    1, 3, 1.00,    30, 3, 1, 1, 1), -- Siedler

                                                               ('L', 3, 25, 20, 0,    1, 5, 3.00,    30, 3, 1, 3, 1), -- Steinbeilkämpfer
                                                               ('L', 3, 25, 20, 1,    1, 5, 1.00,    30, 3, 1, 3, 1), -- Bogenschütze
                                                    
                                                               ('L', 4, 50, 5, 0,     1, 3, 3.00,    30, 3, 3, 8, 1), -- Kanone

                                                               ('S', 5, 20, 10, 0,    2, 2, 1.00,    30, 3, 1, 1, 1), -- Segelschiff
                                                               ('S', 6, 20, 10, 0,    2, 3, 3.00,    30, 3, 1, 8, 1), -- Kanonenschiff
                                                    
                                                               ('F', 7, 100, 10, 0,   3, 8, 1.00,    30, 3, 1, 10, 1), -- Jäger
                                                               ('F', 8, 100, 10, 0,   3, 8, 1.00,    30, 3, 1, 10, 1), -- Bomber
                                                    
                                                               others => ('@', 0, 0, 0, 0,    1, 0, 0.00,    1, 1, 0, 0, 1)));

   procedure Beschreibung (ID : in GlobaleDatentypen.EinheitenID);
   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Natural);   
   procedure HeilungBewegungspunkteFürNeueRundeSetzen;
   procedure EinheitErzeugen (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer, ID : in Positive);   
   procedure EinheitEntfernenMitSortieren (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive);
   procedure EinheitEntfernenOhneSortieren (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive);
   procedure EinheitGebautSortieren (RasseExtern : in GlobaleDatentypen.Rassen);   
   procedure Beschäftigung (Arbeit : in Natural);

   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Natural) return Boolean;

private
   
   Wahl : Integer;
   EinheitenPosition : Integer;
   SortierNummer : Integer;
   
   Heilungsrate : constant Integer := 10;   

   Position : GlobaleRecords.AchsenAusKartenfeldPositiv;
   
   type SortierenArray is array (GlobaleVariablen.EinheitenGebautArray'Range (2)) of GlobaleRecords.EinheitenGebautRecord;
   Sortieren : SortierenArray;

end EinheitenDatenbank;
