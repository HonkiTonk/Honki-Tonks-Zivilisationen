pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungKonstanten;

with DatenbankRecords;

package ForschungenTesorahn is

   ForschungslisteTesorahn : constant DatenbankRecords.ForschungslisteArray := (
                                                                                -- Steinwerkzeuge
                                                                                1 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Korallenzucht
                                                                                2 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Muschelkunst
                                                                                3 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Knochenverarbeitung
                                                                                4 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 1,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Mineralienabbau
                                                                                5 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 1,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Fischverwertung
                                                                                6 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 2,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Schrift
                                                                                7 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 3,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Muschelgeld
                                                                                8 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 3,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Atemblase
                                                                                9 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 6,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Schiffsbau
                                                                                10 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 4,
                                                                                      2      => 9,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Feuer
                                                                                11 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 10,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Wasserplattform
                                                                                12 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 10,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Biologie
                                                                                13 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 6,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handel
                                                                                14 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 8,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Buchhaltung
                                                                                15 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 11,
                                                                                      2      => 5,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Kunsthandel
                                                                                16 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 16,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Mathematik
                                                                                17 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 15,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handelsschiffe
                                                                                18 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 12,
                                                                                      2      => 14,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Heilkunde
                                                                                19 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 13,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Oberflächenkunde
                                                                                20 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 12,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Eisenverarbeitung
                                                                                21 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 5,
                                                                                      2      => 11,
                                                                                      3      => 12,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Physik
                                                                                22 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 12,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Landkonstruktionen
                                                                                23 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 20,
                                                                                      2      => 21,
                                                                                      3      => 22,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Dampfmaschine
                                                                                24 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 23,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Oberflächentierzucht
                                                                                25 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 13,
                                                                                      2      => 23,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Navigation
                                                                                26 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 17,
                                                                                      2      => 22,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handelsvereinigung
                                                                                27 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 15,
                                                                                      2      => 18,
                                                                                      3      => 26,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handelskunst
                                                                                28 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 16,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Dampfschiffe
                                                                                29 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 18,
                                                                                      2      => 24,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handels- und Schiffahrtsunion
                                                                                30 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 27,
                                                                                      2      => 28,
                                                                                      3      => 29,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Verbrennungsmotor
                                                                                31 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 29,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Bergbau
                                                                                32 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 23,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Metallurgie
                                                                                33 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 32,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Feuerwaffen
                                                                                34 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 32,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Medizin
                                                                                35 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 19,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Motorenschiffe
                                                                                36 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 31,
                                                                                      2      => 33,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Schlachtschiffe
                                                                                37 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 30,
                                                                                      2      => 34,
                                                                                      3      => 36,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Landschiffe
                                                                                38 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 36,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Elektrizität
                                                                                39 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 33,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Funk
                                                                                40 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 39,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Computer
                                                                                41 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 39,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Kabellose Übertragung
                                                                                42 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 40,
                                                                                      2      => 41,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Gezeiten/Wasserkraft
                                                                                43 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 39,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Genetik
                                                                                44 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 35,
                                                                                      2      => 41,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Hochleistungsmaterialien
                                                                                45 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 43,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Atomtheorie
                                                                                46 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 42,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Nanotechnologie
                                                                                47 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 46,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Kernstädte
                                                                                48 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 44,
                                                                                      2      => 45,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Quantencomputer
                                                                                49 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 47,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- NAMR-Reaktor
                                                                                50 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 43,
                                                                                      2      => 49,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Hochleistungsmagnettechnologie
                                                                                51 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 45,
                                                                                      2      => 50,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- NAMR-Theorie
                                                                                52 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 50,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Unvollständige Raumebenentheorie
                                                                                53 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 52,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Gaußwaffen
                                                                                54 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 51,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Magnetschilde
                                                                                55 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 51,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Permanenter magnetoplasmadynamischer Antrieb
                                                                                56 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 51,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Magnetische Kampfsysteme
                                                                                57 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 54,
                                                                                      2      => 55,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Raketentechnologie
                                                                                58 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 56,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Himmel/Orbitalstädte
                                                                                59 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 44,
                                                                                      2      => 58,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Asteroidenbergbau
                                                                                60 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 59,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Interstellarer Antrieb
                                                                                61 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      1      => 53,
                                                                                      2      => 59,
                                                                                      others => 0
                                                                                     )
                                                                                  ),

                                                                                others => ForschungKonstanten.LeerForschungListe
                                                                               );

end ForschungenTesorahn;
