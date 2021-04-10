pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleRecords, GlobaleDatentypen, DatenbankRecords;
use GlobaleDatentypen, GlobaleRecords;

package EinheitenDatenbank is   

   LeererWertEinheitListe : constant DatenbankRecords.EinheitenListeRecord := ('@',            -- 1. Wert = EinheitenGrafik
                                                                               1, 0, 0, 0,     -- 2. Wert = EinheitTyp, 3. Wert = PreisGeld, 4. Wert = PreisRessourcen, 5. Wert = Anforderungen
                                                                               (others => False), 0, 0.00,     -- 6. Wert = Passierbarkeit, 7. Wert = MaximaleLebenspunkte, 8. Wert = MaximaleBewegungspunkte
                                                                               1, 1, 0, 0, 1, -- 9. Wert = Beförderungsgrenze, 10. Wert = MaximalerRang, 11. Wert = Reichweite, 12. Wert = Angriff, 13. Wert = Verteidigung
                                                                               0, 0); -- 14. Wert = Kann Dinge transportieren, 15. Wert = Kann transportiert werden

   -- 1. EinheitTyp = Siedler, 2. EinheitenTyp = Bauarbeiter, 3. EinheitenTyp = Platzhalter für Anderes !!!Später einbauen/nutzen!!!
   type EinheitenListeArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.EinheitenID'Range) of DatenbankRecords.EinheitenListeRecord;
   EinheitenListe : constant EinheitenListeArray
     := (others => (('S',    1, 10, 10, 0,    (1 => True, others => False), 3, 1.00,    30, 3, 1, 1, 1,    0, 1), -- Siedler

                    ('L',    3, 25, 20, 0,    (1 => True, others => False), 5, 3.00,    30, 3, 1, 3, 1,    0, 1), -- Steinbeilkämpfer
                    ('L',    3, 25, 20, 1,    (1 => True, others => False), 5, 1.00,    30, 3, 1, 3, 1,    0, 1), -- Bogenschütze
                    ('L',    4, 50, 5, 0,     (1 => True, others => False), 3, 3.00,    30, 3, 3, 8, 1,    0, 2), -- Kanone

                    ('S',    5, 20, 10, 0,    (2 => True, others => False), 2, 1.00,    30, 3, 1, 1, 1,    2, 0), -- Segelschiff
                    ('S',    6, 20, 10, 0,    (2 => True, others => False), 3, 3.00,    30, 3, 1, 8, 1,    2, 0), -- Kanonenschiff
                    ('U',    6, 20, 10, 0,    (2 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0), -- UBoot
                                                    
                    ('F',    7, 100, 10, 0,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1), -- Jäger
                    ('F',    8, 100, 10, 0,   (1 => True, 2 => True, 3 => True, others => False), 8, 1.00,    30, 3, 1, 10, 1,    0, 1), -- Bomber
                    ('R',    7, 20, 10, 0,    (1 => True, 2 => True, 3 => True, 4 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0), -- Rakete
                    ('R',    7, 20, 10, 0,    (1 => True, 2 => True, 3 => True, 4 => True, 5 => True, others => False), 1000, 100.00,    30, 3, 1, 10, 10,    0, 0), -- Unterwasserrakete
                    
                                                               
                    others => LeererWertEinheitListe));
   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch, 7 = Planeteninneres

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.EinheitenID);
   procedure LebenspunkteBewegungspunkteAufMaximumSetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));
   
   procedure HeilungBewegungspunkteNeueRundeErmitteln;
   procedure EinheitErzeugen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID)
     with
       Pre => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= 0));

   procedure EinheitEntfernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));
   
   procedure Beschäftigung
     (ArbeitExtern : in Natural);

   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean;
   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert;

private
   
   Heilungsrate : constant Positive := 10;

   Taste : Wide_Wide_Character;
   
   AktuelleAuswahl : Natural;
   Ende : Natural;
   AktuellePosition : Positive;
   Wahl : Integer;

   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;

   Position : GlobaleRecords.AchsenKartenfeldPositivRecord;

   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0);
     

end EinheitenDatenbank;
