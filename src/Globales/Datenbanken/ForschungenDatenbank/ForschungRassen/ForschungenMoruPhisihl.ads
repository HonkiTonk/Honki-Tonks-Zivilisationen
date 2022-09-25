pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungKonstanten;
with ForschungenDatentypen;

with DatenbankRecords;

package ForschungenMoruPhisihl is

   ForschungslisteMoruPhisihl : constant DatenbankRecords.ForschungslisteArray := (
                                                                                   -- Steinwerkzeuge
                                                                                   1 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         others => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Einfache Landwirtschaft
                                                                                   2 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         others => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Frühe Handwerke
                                                                                   3 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         others => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Höhlenmalerei
                                                                                   4 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         others => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Rad
                                                                                   5 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Bergbau
                                                                                   6 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Frühe Schiffahrt
                                                                                   7 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 1,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 3,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Mathematik
                                                                                   8 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 4,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Schrift
                                                                                   9 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 4,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Bronzeverarbeitung
                                                                                   10 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 6,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 3,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Einfache Konstruktionen
                                                                                   11 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 10,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 8,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Physik
                                                                                   12 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 11,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 9,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Eisenverarbeitung
                                                                                   13 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 10,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Segelschiffe
                                                                                   14 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 7,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 11,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Radkonstruktionen
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

                                                                                     -- Bewässerungstechnik
                                                                                   16 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 11,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 2,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Erste Maschinen
                                                                                   17 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 12,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 13,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Brückenbau
                                                                                   18 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 11,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Verbesserte Landwirtschaft
                                                                                   19 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 16,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 15,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Chemie
                                                                                   20 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 19,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Buchdruck
                                                                                   21 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 20,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 9,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Fortschrittliche Konstruktionen
                                                                                   22 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 17,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 18,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Große Segelschiffe
                                                                                   23 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 22,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 14,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Biologie
                                                                                   24 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 19,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Schwere Befestigungen
                                                                                   25 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 22,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Schießpulver
                                                                                   26 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 25,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 20,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Ingenieurswesen
                                                                                   27 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 25,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 21,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Feuerwaffen
                                                                                   28 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 26,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Dampfmaschine
                                                                                   29 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 27,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Angetriebene Maschinen
                                                                                   30 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 29,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Dampfschiffe
                                                                                   31 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 30,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 23,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Petrochemie
                                                                                   32 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 30,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 20,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Stahl
                                                                                   33 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 20,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Kanonen
                                                                                   34 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 33,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 28,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Eisenbahn
                                                                                   35 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 30,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Elektrizität
                                                                                   36 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 27,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Generator/Motortechnik
                                                                                   37 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
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
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 37,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 31,
                                                                                         ForschungenDatentypen.Anforderung_Drei_Enum => 34,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- U-Boot
                                                                                   39 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 38,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Fahrzeug
                                                                                   40 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 37,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Flugzeug
                                                                                   41 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 37,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Panzer
                                                                                   42 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 40,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 34,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Medizin
                                                                                   43 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 32,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 24,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Naturwissenschaft
                                                                                   44 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
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
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Raketentechnik
                                                                                   46 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Laser
                                                                                   47 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Mikroeletronik
                                                                                   48 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 47,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Computer
                                                                                   49 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 48,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Orbitale Objekte
                                                                                   50 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 46,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Düsenflugzeuge
                                                                                   51 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 46,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Genetik
                                                                                   52 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 43,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Regenerative Energien
                                                                                   53 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 44,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Astroidenbergbau
                                                                                   54 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
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
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 49,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 45,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Genetische Modifikationen
                                                                                   56 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 52,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 49,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Cyborgisierung
                                                                                   57 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 55,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 56,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Komplexe Konstruktionen
                                                                                   58 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 55,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 54,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Quantencomputer
                                                                                   59 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 55,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Kernfusion
                                                                                   60 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 58,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Kalte Kernfusion
                                                                                   61 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 60,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Unterwasser/Unterirdische Städte
                                                                                   62 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 58,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- NAMR Reaktor
                                                                                   63 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 61,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 59,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Hochleistungsmaterialien
                                                                                   64 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 63,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 62,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Planetenkernstädte
                                                                                   65 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 64,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- NAMR-Theorie
                                                                                   66 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 63,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Hochleistungsmagnettechnologie
                                                                                   67 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 66,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 64,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Gauß-Waffen
                                                                                   68 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 67,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Magnetschilde
                                                                                   69 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 67,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Unvollständige Raumebenentheorie
                                                                                   70 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 66,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Permanenter magnetoplasmadynamischer Antrieb
                                                                                   71 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 67,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Himmel/Orbitalstädte
                                                                                   72 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 71,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Interstellarer Antrieb
                                                                                   73 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 69,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 70,
                                                                                         ForschungenDatentypen.Anforderung_Drei_Enum => 71,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                     -- Magnetische Kampfsysteme
                                                                                   74 =>
                                                                                     (
                                                                                      PreisForschung       => 100,
                                                                                      AnforderungForschung =>
                                                                                        (
                                                                                         ForschungenDatentypen.Anforderung_Eins_Enum => 71,
                                                                                         ForschungenDatentypen.Anforderung_Zwei_Enum => 68,
                                                                                         ForschungenDatentypen.Anforderung_Drei_Enum => 69,
                                                                                         others                                      => 0
                                                                                        )
                                                                                     ),

                                                                                   others => ForschungKonstanten.LeerForschungListe
                                                                                  );

end ForschungenMoruPhisihl;
