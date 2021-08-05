pragma SPARK_Mode (On);

with GlobaleKonstanten;

with DatenbankRecords;

package ForschungMenschen is

   ForschungMenschenListe : constant DatenbankRecords.ForschungListeArray :=
     (
      -- Steinwerkzeuge
      1 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Einfache Landwirtschaft
      2 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Frühe Schifffahrt
      3 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 1,
                                  others => 0)),

      -- Anfängliche Mineralienkunde
      4 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Erste Werkstoffe (Keramik)
      5 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 4,
                                  others => 0)),

      -- Bergbau
      6 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 1,
                                  2 => 4,
                                  others => 0)),

      -- Kupfer
      7 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 6,
                                  others => 0)),

      -- Bronzeverarbeitung
      8 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 7,
                                  others => 0)),

      -- Bronzewerkzeuge
      9 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 8,
                                  others => 0)),

      -- Rad
      10 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 9,
                                  others => 0)),

      -- Schrift
      11 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Mathematik
      12 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Segelschiffe
      13 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 12,
                                  2 => 9,
                                  3 => 3,
                                  4 => 14)),

      -- Einfache Konstruktionen
      14 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 12,
                                  2 => 9,
                                  others => 0)),

      -- Bewässerungstechnik
      15 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 14,
                                  2 => 2,
                                  others => 0)),

      -- Eisenverarbeitung
      16 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 4,
                                  2 => 8,
                                  others => 0)),

      -- Physik
      17 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 11,
                                  2 => 12,
                                  others => 0)),

      -- Erste Maschinen
      18 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 17,
                                  2 => 14,
                                  3 => 19,
                                  others => 0)),

      -- Eisenwerkzeuge
      19 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 16,
                                  others => 0)),

      -- Brückenbau
      20 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 21,
                                  others => 0)),

      -- Bessere Konstruktionen
      21 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 19,
                                  2 => 18,
                                  3 => 17,
                                  others => 0)),

      -- Wasserrad
      22 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 21,
                                  others => 0)),

      -- Windrad
      23 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 23,
                                  others => 0)),

      -- Bessere Landwirtschaft
      24 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 2,
                                  2 => 19,
                                  others => 0)),

      -- Schwere Befestigungen
      25 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 21,
                                  2 => 19,
                                  others => 0)),

      -- Festungsbauten
      26 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 25,
                                  2 => 33,
                                  others => 0)),

      -- Werkzeugverbesserungen
      27 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 19,
                                  2 => 21,
                                  3 => 12,
                                  4 => 17)),

      -- Buchdruck
      28 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 27,
                                  2 => 11,
                                  others => 0)),

      -- Leistungsfähige Messinstrumente
      29 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 27,
                                  2 => 17,
                                  3 => 12,
                                  others => 0)),

      -- Biologie
      30 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 27,
                                  2 => 29,
                                  others => 0)),

      -- Chemie
      31 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 27,
                                  2 => 29,
                                  others => 0)),

      -- Schießpulver
      32 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 31,
                                  2 => 4,
                                  others => 0)),

      -- Feuerwaffen
      33 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 32,
                                  others => 0)),

      -- Dampfmaschine
      34 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 31,
                                  2 => 17,
                                  3 => 27,
                                  others => 0)),

      -- Angetriebene Maschinen
      35 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 34,
                                  others => 0)),

      -- Eisenbahn
      36 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 35,
                                  2 => 37,
                                  others => 0)),

      -- Stahl
      37 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 31,
                                  2 => 29,
                                  3 => 35,
                                  others => 0)),

      -- Dampfschiffe
      38 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 35,
                                  2 => 39,
                                  others => 0)),

      -- Große Segelschiffe
      39 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 13,
                                  2 => 18,
                                  3 => 19,
                                  others => 0)),

      -- Elektrizität
      40 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 35,
                                  2 => 41,
                                  others => 0)),

      -- Fortgeschrittene Materialienkunde
      41 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 37,
                                  2 => 4,
                                  3 => 31,
                                  4 => 17)),

      -- Massentransport
      42 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 38,
                                  2 => 36,
                                  others => 0)),

      -- Generatortechnik
      43 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 40,
                                  2 => 41,
                                  3 => 38,
                                  others => 0)),

      -- Motorentechnik
      44 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 41,
                                  2 => 40,
                                  3 => 35,
                                  4 => 45)),

      -- Petrochemie
      45 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 31,
                                  2 => 41,
                                  others => 0)),

      -- Automobil
      46 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 44,
                                  2 => 45,
                                  3 => 41,
                                  4 => 48)),

      -- Flugzeug
      47 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 45,
                                  2 => 44,
                                  3 => 41,
                                  4 => 48)),

      -- Fortschrittliche Physik
      48 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 17,
                                  2 => 40,
                                  3 => 50,
                                  others => 0)),

      -- U-Boote
      49 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 48,
                                  2 => 38,
                                  3 => 44,
                                  4 => 43)),

      -- Fortgeschrittene Mathematik
      50 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 12,
                                  2 => 40,
                                  others => 0)),

      -- Atomtheorie
      51 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 48,
                                  others => 0)),

      -- Bessere Schiffe
      52 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 48,
                                  2 => 38,
                                  3 => 44,
                                  4 => 43)),

      -- Raketentechnik
      53 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 48,
                                  2 => 50,
                                  others => 0)),

      -- Düsenflugzeuge
      54 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 53,
                                  2 => 47,
                                  others => 0)),

      -- Lasertechnologie
      55 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 50,
                                  2 => 48,
                                  others => 0)),

      -- Orbitale Objekte
      56 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 53,
                                  2 => 54,
                                  3 => 57,
                                  others => 0)),

      -- Mikroeletronik
      57 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 50,
                                  2 => 48,
                                  others => 0)),

      -- Computer
      58 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 57,
                                  2 => 55,
                                  others => 0)),

      -- Komplexe Materialienkunde
      59 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 58,
                                  2 => 48,
                                  3 => 41,
                                  others => 0)),

      -- Komplexe Werkzeugmaschinen
      60 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 58,
                                  2 => 27,
                                  3 => 35,
                                  others => 0)),

      -- Regenerative Energien
      61 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 59,
                                  2 => 60,
                                  others => 0)),

      -- Genetik
      62 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 30,
                                  2 => 58,
                                  others => 0)),

      -- Genetische Modifikationen
      63 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 62,
                                  others => 0)),

      -- Computerisierung
      64 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 58,
                                  others => 0)),

      -- Cyborgisierung
      65 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 64,
                                  2 => 63,
                                  others => 0)),

      -- Komplexe Konstruktionen
      66 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 64,
                                  2 => 59,
                                  3 => 60,
                                  4 => 58)),

      -- Unterwasser/Unterirdische Städte
      67 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 66,
                                  others => 0)),

      -- Kernfusion
      68 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 66,
                                  2 => 58,
                                  3 => 61,
                                  others => 0)),

      -- Kalte Kernfusion
      69 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 68,
                                  others => 0)),

      -- Nanotechnologie
      70 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 66,
                                  2 => 65,
                                  others => 0)),

      -- Astroidenbergbau
      71 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 67,
                                  2 => 59,
                                  3 => 60,
                                  4 => 53)),

      --  Technologie
      72 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 69,
                                  2 => 70,
                                  others => 0)),

      --  Reaktor
      73 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 72,
                                  others => 0)),

      -- Hochleistungsmaterialien
      74 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 72,
                                  2 => 67,
                                  others => 0)),

      -- Hochleistungsmagnettechnologie
      75 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 74,
                                  2 => 73,
                                  others => 0)),

      -- Planetenkernstädte
      76 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 74,
                                  2 => 67,
                                  3 => 73,
                                  others => 0)),

      -- Permanenter magnetoplasmadynamischer Antrieb
      77 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 75,
                                  2 => 73,
                                  3 => 74,
                                  others => 0)),

      -- Himmel/Orbitalstädte
      78 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 77,
                                  2 => 76,
                                  3 => 74,
                                  others => 0)),

      -- Magnetschilde
      79 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 74,
                                  2 => 73,
                                  3 => 75,
                                  others => 0)),

      -- Gaußwaffen
      80 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 75,
                                  2 => 74,
                                  3 => 73,
                                  others => 0)),

      -- Unvollständige  Theorie
      81 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 72,
                                  others => 0)),

      -- Quantencomputer
      82 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 81,
                                  2 => 64,
                                  3 => 50,
                                  4 => 48)),

      -- Interstellarer Antrieb
      83 =>
        (PreisForschung => 100,
         AnforderungForschung => (1 => 74,
                                  2 => 82,
                                  3 => 73,
                                  4 => 75)),

      others => GlobaleKonstanten.LeerForschungListe
     );

end ForschungMenschen;
