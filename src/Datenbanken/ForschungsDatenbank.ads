pragma SPARK_Mode (On);

with GlobaleDatentypen, DatenbankRecords, GlobaleVariablen;
use GlobaleDatentypen;

package ForschungsDatenbank is

   -- Hier noch hinschreiben welcher Wert was ist!
   LeererWertForschungListe : constant DatenbankRecords.ForschungListeRecord := (0, (others => 0)); -- 1. Wert = PreisForschung, 2. Wert = AnforderungForschung

   type ForschungListeArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray := (1 => (1 => (100, (others => 0)), -- Einfache Landwirtschaft
                                                  2 => (100, (others => 0)), --
                                                  3 => (100, (others => 0)), --

                                                  4 => (250, (1, 2, 0, 0)), --
                                                  5 => (250, (2, 3, 0, 0)), --
                                                  6 => (250, (4, 0, 0, 0)), --

                                                  others => LeererWertForschungListe),

                                            2 => (1 => (100, (others => 0)), --
                                                  2 => (100, (others => 0)), --
                                                  3 => (100, (others => 0)), --

                                                  4 => (250, (1, 2, 0, 0)), --
                                                  5 => (250, (2, 3, 0, 0)), --
                                                  6 => (250, (4, 0, 0, 0)), --

                                                  others => LeererWertForschungListe),

                                            3 => (1 => (100, (others => 0)), --
                                                  2 => (100, (others => 0)), --
                                                  3 => (100, (others => 0)), --

                                                  4 => (250, (1, 2, 0, 0)), --
                                                  5 => (250, (2, 3, 0, 0)), --
                                                  6 => (250, (4, 0, 0, 0)), --

                                                  others => LeererWertForschungListe),

                                            4 => (1 => (100, (others => 0)), --
                                                  2 => (100, (others => 0)), --
                                                  3 => (100, (others => 0)), --

                                                  4 => (250, (1, 2, 0, 0)), --
                                                  5 => (250, (2, 3, 0, 0)), --
                                                  6 => (250, (4, 0, 0, 0)), --

                                                  others => LeererWertForschungListe),

                                            5 => (1 => (100, (others => 0)), --
                                                  2 => (100, (others => 0)), --
                                                  3 => (100, (others => 0)), --

                                                  4 => (250, (1, 2, 0, 0)), --
                                                  5 => (250, (2, 3, 0, 0)), --
                                                  6 => (250, (4, 0, 0, 0)), --

                                                  others => LeererWertForschungListe),

                                            6 => (1 => (100, (others => 0)), --
                                                  2 => (100, (others => 0)), --
                                                  3 => (100, (others => 0)), --

                                                  4 => (250, (1, 2, 0, 0)), --
                                                  5 => (250, (2, 3, 0, 0)), --
                                                  6 => (250, (4, 0, 0, 0)), --

                                                  others => LeererWertForschungListe),

                                            7 => (1 => (100, (others => 0)), --
                                                  2 => (100, (others => 0)), --
                                                  3 => (100, (others => 0)), --

                                                  4 => (250, (1, 2, 0, 0)), --
                                                  5 => (250, (2, 3, 0, 0)), --
                                                  6 => (250, (4, 0, 0, 0)), --

                                                  others => LeererWertForschungListe),

                                            8 => (1 => (100, (others => 0)), --
                                                  2 => (100, (others => 0)), --
                                                  3 => (100, (others => 0)), --

                                                  4 => (250, (1, 2, 0, 0)), --
                                                  5 => (250, (2, 3, 0, 0)), --
                                                  6 => (250, (4, 0, 0, 0)), --

                                                  others => LeererWertForschungListe),

                                            9 => (1 => (100, (others => 0)), --
                                                  2 => (100, (others => 0)), --
                                                  3 => (100, (others => 0)), --

                                                  4 => (250, (1, 2, 0, 0)), --
                                                  5 => (250, (2, 3, 0, 0)), --
                                                  6 => (250, (4, 0, 0, 0)), --

                                                  others => LeererWertForschungListe),

                                            10 => (1 => (100, (others => 0)), --
                                                   2 => (100, (others => 0)), --
                                                   3 => (100, (others => 0)), --

                                                   4 => (250, (1, 2, 0, 0)), --
                                                   5 => (250, (2, 3, 0, 0)), --
                                                   6 => (250, (4, 0, 0, 0)), --

                                                   others => LeererWertForschungListe),

                                            11 => (1 => (100, (others => 0)), --
                                                   2 => (100, (others => 0)), --
                                                   3 => (100, (others => 0)), --

                                                   4 => (250, (1, 2, 0, 0)), --
                                                   5 => (250, (2, 3, 0, 0)), --
                                                   6 => (250, (4, 0, 0, 0)), --

                                                   others => LeererWertForschungListe),

                                            12 => (1 => (100, (others => 0)), --
                                                   2 => (100, (others => 0)), --
                                                   3 => (100, (others => 0)), --

                                                   4 => (250, (1, 2, 0, 0)), --
                                                   5 => (250, (2, 3, 0, 0)), --
                                                   6 => (250, (4, 0, 0, 0)), --

                                                   others => LeererWertForschungListe),

                                            13 => (1 => (100, (others => 0)), --
                                                   2 => (100, (others => 0)), --
                                                   3 => (100, (others => 0)), --

                                                   4 => (250, (1, 2, 0, 0)), --
                                                   5 => (250, (2, 3, 0, 0)), --
                                                   6 => (250, (4, 0, 0, 0)), --

                                                   others => LeererWertForschungListe),

                                            14 => (1 => (100, (others => 0)), --
                                                   2 => (100, (others => 0)), --
                                                   3 => (100, (others => 0)), --

                                                   4 => (250, (1, 2, 0, 0)), --
                                                   5 => (250, (2, 3, 0, 0)), --
                                                   6 => (250, (4, 0, 0, 0)), --

                                                   others => LeererWertForschungListe),

                                            15 => (1 => (100, (others => 0)), --
                                                   2 => (100, (others => 0)), --
                                                   3 => (100, (others => 0)), --

                                                   4 => (250, (1, 2, 0, 0)), --
                                                   5 => (250, (2, 3, 0, 0)), --
                                                   6 => (250, (4, 0, 0, 0)), --

                                                   others => LeererWertForschungListe),

                                            16 => (1 => (100, (others => 0)), --
                                                   2 => (100, (others => 0)), --
                                                   3 => (100, (others => 0)), --

                                                   4 => (250, (1, 2, 0, 0)), --
                                                   5 => (250, (2, 3, 0, 0)), --
                                                   6 => (250, (4, 0, 0, 0)), --

                                                   others => LeererWertForschungListe),

                                            17 => (1 => (100, (others => 0)), --
                                                   2 => (100, (others => 0)), --
                                                   3 => (100, (others => 0)), --

                                                   4 => (250, (1, 2, 0, 0)), --
                                                   5 => (250, (2, 3, 0, 0)), --
                                                   6 => (250, (4, 0, 0, 0)), --

                                                   others => LeererWertForschungListe),

                                            18 => (1 => (100, (others => 0)), --
                                                   2 => (100, (others => 0)), --
                                                   3 => (100, (others => 0)), --

                                                   4 => (250, (1, 2, 0, 0)), --
                                                   5 => (250, (2, 3, 0, 0)), --
                                                   6 => (250, (4, 0, 0, 0)), --

                                                   others => LeererWertForschungListe));

   type RassenAufschlagArray is array (GlobaleDatentypen.Rassen'Range) of Natural;
   RassenAufschlagForschung : constant RassenAufschlagArray := (1 => 0,
                                                                2 => 0,
                                                                3 => 0,
                                                                4 => 0,
                                                                5 => 0,
                                                                6 => 0,
                                                                7 => 0,
                                                                8 => 0,
                                                                9 => 0,
                                                                10 => 0,
                                                                11 => 0,
                                                                12 => 0,
                                                                13 => 0,
                                                                14 => 0,
                                                                15 => 0,
                                                                16 => 0,
                                                                17 => 0,
                                                                18 => 0);

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.ForschungIDMitNullWert);

   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure ForschungFortschritt;

   procedure ForschungZeit
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

private

   AnforderungenErfüllt : Boolean;

   Taste : Wide_Wide_Character;

   WasErforschtWerdenSoll : GlobaleDatentypen.ForschungIDMitNullWert;

   AktuelleAuswahl : GlobaleDatentypen.KartenverbesserungEinheitenID;
   Ende : GlobaleDatentypen.ForschungID;

   function AuswahlForschungNeu
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

end ForschungsDatenbank;
