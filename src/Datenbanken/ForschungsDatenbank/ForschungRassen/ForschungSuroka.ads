pragma SPARK_Mode (On);

with GlobaleKonstanten;

with DatenbankRecords;

package ForschungSuroka is

   ForschungSurokaListe : constant DatenbankRecords.ForschungListeArray :=
     (
      -- Einfache Landwirtschaft
      1 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Straßen
      2 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Mineralienkunde
      3 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Schrift
      4 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Primitive Werkzeuge
      5 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Rad
      6 =>
        (PreisForschung       => 250,
         AnforderungForschung => (2, 0, 0, 0)),

        -- Mathematik
      7 =>
        (PreisForschung       => 250,
         AnforderungForschung => (4, 0, 0, 0)),

        -- Metallverarbeitung
      8 =>
        (PreisForschung       => 250,
         AnforderungForschung => (3, 5, 0, 0)),

        -- Steinbearbeitung
      9 =>
        (PreisForschung       => 250,
         AnforderungForschung => (5, 0, 0, 0)),

        -- Frühe Konstruktionen
      10 =>
        (PreisForschung       => 250,
         AnforderungForschung => (5, 7, 0, 0)),

        -- Ägyptisches Nilschiff
      11 =>
        (PreisForschung       => 250,
         AnforderungForschung => (0, 0, 0, 0)),

      others => GlobaleKonstanten.LeerForschungListe
     );

end ForschungSuroka;
