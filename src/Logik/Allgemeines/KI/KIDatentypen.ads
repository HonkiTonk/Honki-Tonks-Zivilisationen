pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KIDatentypen is

   type Einheit_Aufgabe_Enum is (
                                 Tut_Nichts_Enum,

                                 Stadt_Bauen_Enum, Flucht_Enum, Erkunden_Enum, Verbesserung_Anlegen_Enum, Angreifen_Enum, Verteidigen_Enum, Einheit_Heilen_Enum, Einheit_Auflösen_Enum,
                                 Einheit_Festsetzen_Enum, Einheit_Verbessern_Enum, Stadt_Bewachen_Enum, Verbesserung_Zerstören_Enum, Auf_Transporter_Warten_Enum
                                );

   type Stadt_Aufgabe_Enum is (
                               Keine_Aufgabe_Enum,

                               Einheit_Bauen_Enum, Gebäude_Bauen_Enum, Gefahr_Einheit_Bauen_Enum
                              );

   type Bewegung_Enum is (
                          Belegt_Angriff_Enum, Unbelegt_Enum, Belegt_Kein_Angriff_Enum
                         );

   -- Größe später besser anpassen.
   type BauenBewertung is range -500 .. 500;
   subtype BewegungBewertung is BauenBewertung range 0 .. 20;


   type AufgabenWichtigkeit is range -1 .. 100;

   type KINotAus is range 1 .. 100;

end KIDatentypen;
