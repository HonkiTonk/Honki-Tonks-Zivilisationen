pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleRecords, GlobaleDatentypen, DatenbankRecords;
use GlobaleDatentypen, GlobaleRecords;

package EinheitenDatenbank is   

   LeererWertEinheitListe : constant DatenbankRecords.EinheitenListeRecord := ('@',            -- 1. Wert = EinheitenGrafik
                                                                               1, 0, 0, 0,     -- 2. Wert = EinheitTyp, 3. Wert = PreisGeld, 4. Wert = PreisRessourcen, 5. Wert = Anforderungen
                                                                               1, 0, 0.00,     -- 6. Wert = Passierbarkeit, 7. Wert = MaximaleLebenspunkte, 8. Wert = MaximaleBewegungspunkte
                                                                               1, 1, 0, 0, 1); -- 9. Wert = Beförderungsgrenze, 10. Wert = MaximalerRang, 11. Wert = Reichweite, 12. Wert = Angriff, 13. Wert = Verteidigung

   -- 1. EinheitTyp = Siedler, 2. EinheitenTyp = Bauarbeiter, 3. EinheitenTyp = Platzhalter für Anderes !!!Später einbauen/nutzen!!!
   type EinheitenListeArry is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.EinheitenID'Range) of DatenbankRecords.EinheitenListeRecord;
   EinheitenListe : constant EinheitenListeArry := (others => (('S',    1, 10, 10, 0,    1, 3, 1.00,    30, 3, 1, 1, 1), -- Siedler

                                                               ('L',    3, 25, 20, 0,    1, 5, 3.00,    30, 3, 1, 3, 1), -- Steinbeilkämpfer
                                                               ('L',    3, 25, 20, 1,    1, 5, 1.00,    30, 3, 1, 3, 1), -- Bogenschütze
                                                    
                                                               ('L',    4, 50, 5, 0,     1, 3, 3.00,    30, 3, 3, 8, 1), -- Kanone

                                                               ('S',    5, 20, 10, 0,    2, 2, 1.00,    30, 3, 1, 1, 1), -- Segelschiff
                                                               ('S',    6, 20, 10, 0,    2, 3, 3.00,    30, 3, 1, 8, 1), -- Kanonenschiff
                                                    
                                                               ('F',    7, 100, 10, 0,   3, 8, 1.00,    30, 3, 1, 10, 1), -- Jäger
                                                               ('F',    8, 100, 10, 0,   3, 8, 1.00,    30, 3, 1, 10, 1), -- Bomber
                                                    
                                                               others => LeererWertEinheitListe));

   procedure Beschreibung (ID : in GlobaleDatentypen.EinheitenID);
   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;
   
   procedure HeilungBewegungspunkteFürNeueRundeSetzen;
   procedure EinheitErzeugen (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord; ID : in Positive) with
     Pre => StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure EinheitEntfernenMitSortieren (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure EinheitEntfernenOhneSortieren (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;
   
   procedure Beschäftigung (Arbeit : in Natural);

   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Natural) return Boolean;

private
   
   Wahl : Integer;
   EinheitenPosition : Integer;
   
   Heilungsrate : constant Integer := 10;   

   Position : GlobaleRecords.AchsenKartenfeldPositivRecord;

end EinheitenDatenbank;
