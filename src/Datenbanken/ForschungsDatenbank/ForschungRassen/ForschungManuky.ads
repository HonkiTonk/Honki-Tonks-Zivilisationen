pragma SPARK_Mode (On);

with GlobaleKonstanten;

with DatenbankRecords;

package ForschungManuky is

   ForschungManukyListe : constant DatenbankRecords.ForschungListeArray :=
     (
      -- Steinwerkzeuge
      1 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Einfache Landwirtschaft
      2 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Frühe Handwerke
      3 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Höhlenmalerei
      4 =>
        (PreisForschung       => 100,
         AnforderungForschung => (others => 0)),

        -- Rad
      5 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 1,
                                  others => 0)),

      -- Bergbau
      6 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 1,
                                  others => 0)),

      -- Frühe Schiffahrt
      7 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 1,
                                  2 => 3,
                                  others => 0)),

      -- Mathematik
      8 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 4,
                                  others => 0)),

      -- Schrift
      9 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 4,
                                  others => 0)),

      -- Bronzeverarbeitung
      10 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 6,
                                  2 => 3,
                                  others => 0)),

      -- Einfache Konstruktionen
      11 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 10,
                                  2 => 8,
                                  others => 0)),

      -- Physik
      12 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 11,
                                  2 => 9,
                                  others => 0)),

      -- Eisenverarbeitung
      13 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 10,
                                  others => 0)),

      -- Segelschiffe
      14 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 7,
                                  2 => 11,
                                  others => 0)),

      -- Radkonstruktionen
      15 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 11,
                                  2 => 5,
                                  others => 0)),

      -- Bewässerungstechnik
      16 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 11,
                                  2 => 2,
                                  others => 0)),

      -- Erste Maschinen
      17 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 12,
                                  2 => 13,
                                  others => 0)),

      -- Brückenbau
      18 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 11,
                                  others => 0)),

      -- Verbesserte Landwirtschaft
      19 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 16,
                                  2 => 15,
                                  others => 0)),

      -- Chemie
      20 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 19,
                                  others => 0)),

      -- Buchdruck
      21 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 20,
                                  2 => 9,
                                  others => 0)),

      -- Fortschrittliche Konstruktionen
      22 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 17,
                                  2 => 18,
                                  others => 0)),

      -- Große Segelschiffe
      23 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 22,
                                  2 => 14,
                                  others => 0)),

      -- Biologie
      24 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 19,
                                  others => 0)),

      -- Schwere Befestigungen
      25 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 22,
                                  others => 0)),

      -- Schießpulver
      26 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 25,
                                  2 => 20,
                                  others => 0)),

      -- Ingenieurswesen
      27 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 25,
                                  2 => 21,
                                  others => 0)),

      -- Feuerwaffen
      28 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 26,
                                  others => 0)),

      -- Dampfmaschine
      29 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 27,
                                  others => 0)),

      -- Angetriebene Maschinen
      30 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 29,
                                  others => 0)),

      -- Dampfschiffe
      31 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 30,
                                  2 => 23,
                                  others => 0)),

      -- Petrochemie
      32 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 30,
                                  2 => 20,
                                  others => 0)),

      -- Stahl
      33 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 20,
                                  others => 0)),

      -- Kanonen
      34 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 33,
                                  2 => 28,
                                  others => 0)),

      -- Eisenbahn
      35 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 30,
                                  others => 0)),

      -- Elektrizität
      36 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 27,
                                  others => 0)),

      -- Generator/Motortechnik
      37 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 33,
                                  2 => 35,
                                  3 => 36,
                                  4 => 32)),

      -- Motorenschiffe
      38 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 37,
                                  2 => 31,
                                  3 => 34,
                                  others => 0)),

      -- U-Boot
      39 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 38,
                                  others => 0)),

      -- Fahrzeug
      40 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 37,
                                  others => 0)),

      -- Flugzeug
      41 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 37,
                                  others => 0)),

      -- Panzer
      42 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 40,
                                  2 => 34,
                                  others => 0)),

      -- Medizin
      43 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 32,
                                  2 => 24,
                                  others => 0)),

      -- Naturwissenschaft
      44 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 43,
                                  2 => 40,
                                  3 => 41,
                                  4 => 39)),

      -- Atomtheorie
      45 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 44,
                                  others => 0)),

      -- Raketentechnik
      46 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 44,
                                  others => 0)),

      -- Laser
      47 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 44,
                                  others => 0)),

      -- Mikroeletronik
      48 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 47,
                                  others => 0)),

      -- Computer
      49 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 48,
                                  others => 0)),

      -- Orbitale Objekte
      50 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 46,
                                  others => 0)),

      -- Düsenflugzeuge
      51 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 46,
                                  others => 0)),

      -- Genetik
      52 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 43,
                                  others => 0)),

      -- Regenerative Energien
      53 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 44,
                                  others => 0)),

      -- Astroidenbergbau
      54 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 53,
                                  2 => 50,
                                  3 => 49,
                                  4 => 51)),

      -- Nanotechnologie
      55 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 49,
                                  2 => 45,
                                  others => 0)),

      -- Genetische Modifikationen
      56 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 52,
                                  2 => 49,
                                  others => 0)),

      -- Cyborgisierung
      57 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 55,
                                  2 => 56,
                                  others => 0)),

      -- Komplexe Konstruktionen
      58 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 55,
                                  2 => 54,
                                  others => 0)),

      -- Quantencomputer
      59 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 55,
                                  others => 0)),

      -- Kernfusion
      60 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 58,
                                  others => 0)),

      -- Kalte Kernfusion
      61 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 60,
                                  others => 0)),

      -- Unterwasser/Unterirdische Städte
      62 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 58,
                                  others => 0)),

      -- NAMR Reaktor
      63 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 61,
                                  2 => 59,
                                  others => 0)),

      -- Hochleistungsmaterialien
      64 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 63,
                                  2 => 62,
                                  others => 0)),

      -- Planetenkernstädte
      65 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 64,
                                  others => 0)),

      -- NAMR-Theorie
      66 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 63,
                                  others => 0)),

      -- Hochleistungsmagnettechnologie
      67 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 66,
                                  2 => 64,
                                  others => 0)),

      -- Gauß-Waffen
      68 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 67,
                                  others => 0)),

      -- Magnetschilde
      69 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 67,
                                  others => 0)),

      -- Unvollständige Raumebenentheorie
      70 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 66,
                                  others => 0)),

      -- Permanenter magnetoplasmadynamischer Antrieb
      71 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 67,
                                  others => 0)),

      -- Himmel/Orbitalstädte
      72 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 71,
                                  others => 0)),

      -- Interstellarer Antrieb
      73 =>
        (PreisForschung       => 100,
         AnforderungForschung => (1 => 69,
                                  2 => 70,
                                  3 => 71,
                                  others => 0)),

      others => GlobaleKonstanten.LeerForschungListe
     );

end ForschungManuky;
