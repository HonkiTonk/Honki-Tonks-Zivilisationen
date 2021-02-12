pragma SPARK_Mode (On);

with GlobaleDatentypen, DatenbankRecords;
use GlobaleDatentypen;

package ForschungsDatenbank is

   -- Hier noch hinschreiben welcher Wert was ist!
   LeererWertForschungListe : constant DatenbankRecords.ForschungListeRecord := (0, (others => 0)); -- 1. Wert = PreisForschung, 2. Wert = AnforderungForschung

   type ForschungListeArray is Array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.ErforschtArray'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray := (others => (1 => (100, (others => 0)),
                                                       2 => (100, (others => 0)),
                                                       3 => (100, (others => 0)),

                                                       4 => (250, (1, 2, 0, 0)),
                                                       5 => (250, (2, 3, 0, 0)),
                                                       6 => (250, (4, 0, 0, 0)),

                                                       others => LeererWertForschungListe));

   procedure Beschreibung (ID : in Natural);
   procedure Forschung (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure ForschungFortschritt;
   procedure ForschungZeit (RasseExtern : in GlobaleDatentypen.Rassen);

private

   AnforderungenErfüllt : Boolean;

   Taste : Wide_Wide_Character;

   WasErforschtWerdenSoll : Integer;
   AktuelleAuswahl : Integer;
   Ende : Integer;

   function AuswahlForschung (RasseExtern : in GlobaleDatentypen.Rassen) return Integer;

end ForschungsDatenbank;
