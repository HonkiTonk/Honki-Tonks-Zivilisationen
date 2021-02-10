pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleRecords, GlobaleDatentypen, DatenbankRecords;
use GlobaleDatentypen, GlobaleRecords;

package EinheitenDatenbank is   

   type EinheitenListeArry is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.EinheitenID'Range) of DatenbankRecords.EinheitenListeRecord;
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
   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;
   
   procedure HeilungBewegungspunkteFürNeueRundeSetzen;
   procedure EinheitErzeugen (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer, ID : in Positive);   
   procedure EinheitEntfernenMitSortieren (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure EinheitEntfernenOhneSortieren (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure EinheitGebautSortieren (RasseExtern : in GlobaleDatentypen.Rassen);   
   procedure Beschäftigung (Arbeit : in Natural);

   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Natural) return Boolean;

private
   
   Wahl : Integer;
   EinheitenPosition : Integer;
   SortierNummer : Integer;
   
   Heilungsrate : constant Integer := 10;   

   Position : GlobaleRecords.AchsenAusKartenfeldPositivRecord;
   
   type SortierenArray is array (GlobaleVariablen.EinheitenGebautArray'Range (2)) of GlobaleRecords.EinheitenGebautRecord;
   Sortieren : SortierenArray;

end EinheitenDatenbank;
