with ForschungKonstanten;
with ForschungenDatentypen;
with ForschungsdatenbankRecord;
with ForschungRecordKonstanten;

package ForschungenSuroka is
   pragma Elaborate_Body;

   ForschungslisteSuroka : constant ForschungsdatenbankRecord.ForschungslisteArray := (
                                                                                       -- Steinwerkzeuge
                                                                                       1 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             others => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Einfache Landwirtschaft
                                                                                       2 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             others => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Frühe Handwerke
                                                                                       3 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             others => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Höhlenmalerei
                                                                                       4 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             others => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Rad
                                                                                       5 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Bergbau
                                                                                       6 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Frühe Schiffahrt
                                                                                       7 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 3,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Mathematik
                                                                                       8 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 4,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Schrift
                                                                                       9 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 4,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Bronzeverarbeitung
                                                                                       10 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 6,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 3,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Einfache Konstruktionen
                                                                                       11 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 10,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 8,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Physik
                                                                                       12 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 11,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 9,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Eisenverarbeitung
                                                                                       13 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 10,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Segelschiffe
                                                                                       14 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 7,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 11,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Radkonstruktionen
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

                                                                                         -- Bewässerungstechnik
                                                                                       16 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 11,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 2,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Erste Maschinen
                                                                                       17 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 12,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 13,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Brückenbau
                                                                                       18 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 11,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Verbesserte Landwirtschaft
                                                                                       19 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 16,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 15,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Chemie
                                                                                       20 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 19,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Buchdruck
                                                                                       21 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 20,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 9,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Fortschrittliche Konstruktionen
                                                                                       22 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 17,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 18,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Große Segelschiffe
                                                                                       23 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 22,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 14,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Biologie
                                                                                       24 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 19,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Schwere Befestigungen
                                                                                       25 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 22,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Schießpulver
                                                                                       26 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 25,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 20,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Ingenieurswesen
                                                                                       27 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 25,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 21,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Feuerwaffen
                                                                                       28 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 26,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Dampfmaschine
                                                                                       29 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 27,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Angetriebene Maschinen
                                                                                       30 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 29,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Dampfschiffe
                                                                                       31 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 30,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 23,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Petrochemie
                                                                                       32 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 30,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 20,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Stahl
                                                                                       33 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 20,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Kanonen
                                                                                       34 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 33,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 28,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Eisenbahn
                                                                                       35 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 30,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Elektrizität
                                                                                       36 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 27,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Generator/Motortechnik
                                                                                       37 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 33,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 35,
                                                                                             ForschungenDatentypen.Anforderung_Drei_Enum => 36,
                                                                                             ForschungenDatentypen.Anforderung_Vier_Enum => 32
                                                                                            )
                                                                                         ),

                                                                                         -- Motorenschiffe
                                                                                       38 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 37,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 31,
                                                                                             ForschungenDatentypen.Anforderung_Drei_Enum => 34,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- U-Boot
                                                                                       39 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 38,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Fahrzeug
                                                                                       40 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 37,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Flugzeug
                                                                                       41 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 37,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Panzer
                                                                                       42 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 40,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 34,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Medizin
                                                                                       43 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 32,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 24,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Naturwissenschaft
                                                                                       44 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 43,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 40,
                                                                                             ForschungenDatentypen.Anforderung_Drei_Enum => 41,
                                                                                             ForschungenDatentypen.Anforderung_Vier_Enum => 39
                                                                                            )
                                                                                         ),

                                                                                         -- Atomtheorie
                                                                                       45 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Raketentechnik
                                                                                       46 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Laser
                                                                                       47 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Mikroeletronik
                                                                                       48 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 47,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Computer
                                                                                       49 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 48,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Orbitale Objekte
                                                                                       50 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 46,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Düsenflugzeuge
                                                                                       51 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 46,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Genetik
                                                                                       52 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 43,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Regenerative Energien
                                                                                       53 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Astroidenbergbau
                                                                                       54 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 53,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 50,
                                                                                             ForschungenDatentypen.Anforderung_Drei_Enum => 49,
                                                                                             ForschungenDatentypen.Anforderung_Vier_Enum => 51
                                                                                            )
                                                                                         ),

                                                                                         -- Nanotechnologie
                                                                                       55 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 49,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 45,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Genetische Modifikationen
                                                                                       56 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 52,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 49,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Cyborgisierung
                                                                                       57 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 55,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 56,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Komplexe Konstruktionen
                                                                                       58 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 55,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 54,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Quantencomputer
                                                                                       59 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 55,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Kernfusion
                                                                                       60 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 58,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Kalte Kernfusion
                                                                                       61 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 60,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Unterwasser/Unterirdische Städte
                                                                                       62 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 58,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- NAMR Reaktor
                                                                                       63 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 61,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 59,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Hochleistungsmaterialien
                                                                                       64 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 63,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 62,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Planetenkernstädte
                                                                                       65 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 64,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- NAMR-Theorie
                                                                                       66 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 63,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Hochleistungsmagnettechnologie
                                                                                       67 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 66,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 64,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Gauß-Waffen
                                                                                       68 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 67,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Magnetschilde
                                                                                       69 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 67,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Unvollständige Raumebenentheorie
                                                                                       70 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 66,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Permanenter magnetoplasmadynamischer Antrieb
                                                                                       71 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 67,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Himmel/Orbitalstädte
                                                                                       72 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 71,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Interstellarer Antrieb
                                                                                       73 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 69,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 70,
                                                                                             ForschungenDatentypen.Anforderung_Drei_Enum => 71,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                         -- Magnetische Kampfsysteme
                                                                                       74 =>
                                                                                         (
                                                                                          Kosten      => 100,
                                                                                          Anforderung =>
                                                                                            (
                                                                                             ForschungenDatentypen.Anforderung_Eins_Enum => 71,
                                                                                             ForschungenDatentypen.Anforderung_Zwei_Enum => 68,
                                                                                             ForschungenDatentypen.Anforderung_Drei_Enum => 69,
                                                                                             others                                      => ForschungKonstanten.LeerAnforderung
                                                                                            )
                                                                                         ),

                                                                                       others => ForschungRecordKonstanten.LeerForschungsliste
                                                                                      );

end ForschungenSuroka;
