with ForschungKonstanten;
with ForschungenDatentypen;
with ForschungsdatenbankRecord;
with ForschungRecordKonstanten;

package ForschungenTesorahn is
   pragma Elaborate_Body;

   ForschungslisteTesorahn : constant ForschungsdatenbankRecord.ForschungslisteArray := (
                                                                                         -- Steinwerkzeuge
                                                                                         1 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               others => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Korallenzucht
                                                                                         2 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               others => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Muschelkunst
                                                                                         3 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               others => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Knochenverarbeitung
                                                                                         4 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Mineralienabbau
                                                                                         5 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Fischverwertung
                                                                                         6 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 2,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Schrift
                                                                                         7 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 3,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Muschelgeld
                                                                                         8 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 3,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Atemblase
                                                                                         9 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 6,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Schiffsbau
                                                                                         10 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 4,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 9,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Feuer
                                                                                         11 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 10,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Wasserplattform
                                                                                         12 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 10,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Biologie
                                                                                         13 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 6,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Handel
                                                                                         14 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 8,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Buchhaltung
                                                                                         15 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 11,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 5,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Kunsthandel
                                                                                         16 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 16,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Mathematik
                                                                                         17 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 15,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Handelsschiffe
                                                                                         18 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 12,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 14,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Heilkunde
                                                                                         19 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 13,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Oberflächenkunde
                                                                                         20 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 12,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Eisenverarbeitung
                                                                                         21 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 5,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 11,
                                                                                               ForschungenDatentypen.Anforderung_Drei_Enum => 12,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Physik
                                                                                         22 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 12,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Landkonstruktionen
                                                                                         23 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 20,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 21,
                                                                                               ForschungenDatentypen.Anforderung_Drei_Enum => 22,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Dampfmaschine
                                                                                         24 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 23,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Oberflächentierzucht
                                                                                         25 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 13,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 23,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Navigation
                                                                                         26 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 17,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 22,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Handelsvereinigung
                                                                                         27 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 15,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 18,
                                                                                               ForschungenDatentypen.Anforderung_Drei_Enum => 26,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Handelskunst
                                                                                         28 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 16,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Dampfschiffe
                                                                                         29 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 18,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 24,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Handels- und Schiffahrtsunion
                                                                                         30 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 27,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 28,
                                                                                               ForschungenDatentypen.Anforderung_Drei_Enum => 29,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Verbrennungsmotor
                                                                                         31 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 29,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Bergbau
                                                                                         32 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 23,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Metallurgie
                                                                                         33 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 32,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Feuerwaffen
                                                                                         34 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 32,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Medizin
                                                                                         35 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 19,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Motorenschiffe
                                                                                         36 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 31,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 33,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Schlachtschiffe
                                                                                         37 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 30,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 34,
                                                                                               ForschungenDatentypen.Anforderung_Drei_Enum => 36,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Landschiffe
                                                                                         38 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 36,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Elektrizität
                                                                                         39 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 33,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Funk
                                                                                         40 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 39,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Computer
                                                                                         41 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 39,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Kabellose Übertragung
                                                                                         42 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 40,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 41,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Gezeiten/Wasserkraft
                                                                                         43 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 39,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Genetik
                                                                                         44 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 35,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 41,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Hochleistungsmaterialien
                                                                                         45 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 43,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Atomtheorie
                                                                                         46 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 42,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Nanotechnologie
                                                                                         47 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 46,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Kernstädte
                                                                                         48 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 45,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Quantencomputer
                                                                                         49 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 47,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- NAMR-Reaktor
                                                                                         50 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 43,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 49,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Hochleistungsmagnettechnologie
                                                                                         51 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 45,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 50,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- NAMR-Theorie
                                                                                         52 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 50,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Unvollständige Raumebenentheorie
                                                                                         53 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 52,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Gaußwaffen
                                                                                         54 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 51,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Magnetschilde
                                                                                         55 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 51,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Permanenter magnetoplasmadynamischer Antrieb
                                                                                         56 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 51,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Magnetische Kampfsysteme
                                                                                         57 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 54,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 55,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Raketentechnologie
                                                                                         58 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 56,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Himmel/Orbitalstädte
                                                                                         59 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 58,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Asteroidenbergbau
                                                                                         60 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 59,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                           -- Interstellarer Antrieb
                                                                                         61 =>
                                                                                           (
                                                                                            Kosten      => 100,
                                                                                            Anforderung =>
                                                                                              (
                                                                                               ForschungenDatentypen.Anforderung_Eins_Enum => 53,
                                                                                               ForschungenDatentypen.Anforderung_Zwei_Enum => 59,
                                                                                               others                                      => ForschungKonstanten.LeerAnforderung
                                                                                              )
                                                                                           ),

                                                                                         others => ForschungRecordKonstanten.LeerForschungsliste
                                                                                        );

end ForschungenTesorahn;
