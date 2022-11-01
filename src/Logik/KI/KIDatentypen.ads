pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KIDatentypen is
   pragma Pure;

   -- Leer_Aufgabe_Enum verwenden, wenn noch keine Aufgabe ermittelt wurde. Tut_Nichts, wenn die Einheit diese Runde nichts tun soll.
   type Einheit_Aufgabe_Enum is (
                                 Leer_Aufgabe_Enum,

                                 Tut_Nichts_Enum,
                                 Stadt_Bauen_Enum, Flucht_Enum, Erkunden_Enum, Verbesserung_Anlegen_Enum, Angreifen_Enum, Verteidigen_Enum, Einheit_Heilen_Enum, Einheit_Auflösen_Enum,
                                 Einheit_Festsetzen_Enum, Einheit_Verbessern_Enum, Stadt_Bewachen_Enum, Verbesserung_Zerstören_Enum, Auf_Transporter_Warten_Enum,
                                 Angriffskrieg_Vorbereiten_Enum, Verteidigungskrieg_Vorbereiten_Enum, Platz_Machen_Enum, -- Abholen_Enum,

                                 Planet_Vernichten_Enum
                                );
   subtype Einheit_Aufgabe_Vorhanden_Enum is Einheit_Aufgabe_Enum range Tut_Nichts_Enum .. Einheit_Aufgabe_Enum'Last;

   type Stadt_Aufgabe_Enum is (
                               Keine_Aufgabe_Enum,

                               Einheit_Bauen_Enum, Gebäude_Bauen_Enum, Gefahr_Einheit_Bauen_Enum
                              );

   type Bewegung_Enum is (
                          Belegt_Angriff_Enum, Unbelegt_Enum, Belegt_Kein_Angriff_Enum, Einheiten_Tauschen_Enum
                         );

   -- Größe später besser anpassen. äöü
   type BauenBewertung is range -500 .. 500;
   subtype BewegungBewertung is BauenBewertung range 0 .. 20;

   -- Die beiden Bewertungen zusammenführen, warum sind die überhaupt getrennt? äöü
   type AufgabenWichtigkeit is range -100 .. 100;
   subtype AufgabenWichtigkeitKlein is AufgabenWichtigkeit range -1 .. 100;

   type KINotAus is range 1 .. 50;

   type Zustand_Enum is (
                         Hunger_Enum, Stagniert_Enum,
                         Produktionsverlust_Enum, Produktionsstagnation_Enum,
                         Geldverlust_Enum, Geldstagnation_Enum
                        );

end KIDatentypen;
