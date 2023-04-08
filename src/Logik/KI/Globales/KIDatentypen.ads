package KIDatentypen is
   pragma Pure;

   type Einheit_Aufgabe_Enum is (
                                 Leer_Aufgabe_Enum,

                                 Stadt_Bauen_Enum, Erkunden_Enum, Verbesserung_Anlegen_Enum, Auf_Transporter_Warten_Enum,

                                 Flucht_Enum, Angreifen_Enum, Verteidigen_Enum, Einheit_Heilen_Enum, Einheit_Auflösen_Enum,
                                 Einheit_Festsetzen_Enum, Einheit_Verbessern_Enum, Stadt_Bewachen_Enum, Verbesserung_Zerstören_Enum,
                                 Angriffskrieg_Vorbereiten_Enum, Verteidigungskrieg_Vorbereiten_Enum, Platz_Machen_Enum, -- Abholen_Enum,

                                 Planet_Vernichten_Enum
                                );
   -- Diesen Anfang mal überall einbauen wo es sinnvoll ist. äöü
   subtype Einheit_Aufgabe_Vorhanden_Enum is Einheit_Aufgabe_Enum range Einheit_Aufgabe_Enum'Succ (Einheit_Aufgabe_Enum'First) .. Einheit_Aufgabe_Enum'Last;

   subtype Einheit_Aufgabe_Frieden_Enum is Einheit_Aufgabe_Vorhanden_Enum range Stadt_Bauen_Enum .. Auf_Transporter_Warten_Enum;
   subtype Einheit_Aufgabe_Krieg_Enum is Einheit_Aufgabe_Vorhanden_Enum range Flucht_Enum .. Einheit_Aufgabe_Enum'Last;



   type Stadt_Aufgabe_Enum is (
                               Keine_Aufgabe_Enum,

                               Einheit_Bauen_Enum, Gebäude_Bauen_Enum, Gefahr_Einheit_Bauen_Enum
                              );



   type Bewegung_Enum is (
                          Belegt_Angriff_Enum, Unbelegt_Enum, Belegt_Kein_Angriff_Enum, Einheiten_Tauschen_Enum
                         );



   type Ziel_Suchen_Enum is (
                             Siedeln_Enum, Fliehen_Enum, Erkunden_Enum, Eigenes_Feld_Enum
                            );



   -- Größe später besser anpassen. äöü
   type BauenBewertung is range -500 .. 500;
   subtype BewegungBewertung is BauenBewertung range 0 .. 30;
   -- Diese Art der Bereichseinteilung auch anderswo verwenden? äöü
   subtype Achsenbewertung is BewegungBewertung range 0 .. BewegungBewertung'Last / 3;



   -- Die beiden Bewertungen zusammenführen, warum sind die überhaupt getrennt? äöü
   type AufgabenWichtigkeit is range -100 .. 100;
   subtype AufgabenWichtigkeitKlein is AufgabenWichtigkeit range -1 .. 100;



   type KINotAus is range 1 .. 50;

end KIDatentypen;
