pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungKonstanten;
with ForschungenDatentypen;

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
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Mineralienabbau
                                                                                5 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Fischverwertung
                                                                                6 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 2,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Schrift
                                                                                7 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 3,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Muschelgeld
                                                                                8 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 3,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Atemblase
                                                                                9 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 6,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Schiffsbau
                                                                                10 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 4,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 9,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Feuer
                                                                                11 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 10,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Wasserplattform
                                                                                12 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 10,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Biologie
                                                                                13 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 6,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handel
                                                                                14 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 8,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Buchhaltung
                                                                                15 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 11,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 5,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Kunsthandel
                                                                                16 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 16,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Mathematik
                                                                                17 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 15,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handelsschiffe
                                                                                18 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 12,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 14,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Heilkunde
                                                                                19 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 13,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Oberflächenkunde
                                                                                20 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 12,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Eisenverarbeitung
                                                                                21 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 5,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 11,
                                                                                      ForschungenDatentypen.Anforderung_Drei_Enum => 12,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Physik
                                                                                22 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 12,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Landkonstruktionen
                                                                                23 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 20,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 21,
                                                                                      ForschungenDatentypen.Anforderung_Drei_Enum => 22,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Dampfmaschine
                                                                                24 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 23,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Oberflächentierzucht
                                                                                25 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 13,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 23,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Navigation
                                                                                26 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 17,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 22,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handelsvereinigung
                                                                                27 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 15,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 18,
                                                                                      ForschungenDatentypen.Anforderung_Drei_Enum => 26,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handelskunst
                                                                                28 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 16,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Dampfschiffe
                                                                                29 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 18,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 24,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Handels- und Schiffahrtsunion
                                                                                30 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 27,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 28,
                                                                                      ForschungenDatentypen.Anforderung_Drei_Enum => 29,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Verbrennungsmotor
                                                                                31 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 29,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Bergbau
                                                                                32 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 23,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Metallurgie
                                                                                33 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 32,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Feuerwaffen
                                                                                34 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 32,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Medizin
                                                                                35 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 19,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Motorenschiffe
                                                                                36 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 31,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 33,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Schlachtschiffe
                                                                                37 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 30,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 34,
                                                                                      ForschungenDatentypen.Anforderung_Drei_Enum => 36,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Landschiffe
                                                                                38 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 36,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Elektrizität
                                                                                39 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 33,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Funk
                                                                                40 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 39,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Computer
                                                                                41 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 39,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Kabellose Übertragung
                                                                                42 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 40,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 41,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Gezeiten/Wasserkraft
                                                                                43 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 39,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Genetik
                                                                                44 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 35,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 41,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Hochleistungsmaterialien
                                                                                45 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 43,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Atomtheorie
                                                                                46 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 42,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Nanotechnologie
                                                                                47 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 46,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Kernstädte
                                                                                48 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 45,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Quantencomputer
                                                                                49 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 47,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- NAMR-Reaktor
                                                                                50 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 43,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 49,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Hochleistungsmagnettechnologie
                                                                                51 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 45,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 50,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- NAMR-Theorie
                                                                                52 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 50,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Unvollständige Raumebenentheorie
                                                                                53 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 52,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Gaußwaffen
                                                                                54 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 51,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Magnetschilde
                                                                                55 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 51,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Permanenter magnetoplasmadynamischer Antrieb
                                                                                56 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 51,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Magnetische Kampfsysteme
                                                                                57 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 54,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 55,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Raketentechnologie
                                                                                58 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 56,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Himmel/Orbitalstädte
                                                                                59 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 58,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Asteroidenbergbau
                                                                                60 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 59,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                  -- Interstellarer Antrieb
                                                                                61 =>
                                                                                  (
                                                                                   PreisForschung       => 100,
                                                                                   AnforderungForschung =>
                                                                                     (
                                                                                      ForschungenDatentypen.Anforderung_Eins_Enum => 53,
                                                                                      ForschungenDatentypen.Anforderung_Zwei_Enum => 59,
                                                                                      others                                      => 0
                                                                                     )
                                                                                  ),

                                                                                others => ForschungKonstanten.LeerForschungListe
                                                                               );

end ForschungenTesorahn;
