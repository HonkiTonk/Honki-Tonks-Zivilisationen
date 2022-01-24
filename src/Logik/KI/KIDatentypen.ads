pragma SPARK_Mode (On);

package KIDatentypen is

   type Einheit_Aufgabe_Enum is (Tut_Nichts, Stadt_Bauen, Flucht, Erkunden, Verbesserung_Anlegen, Angreifen, Verteidigen, Einheit_Heilen, Einheit_Auflösen, Einheit_Festsetzen, Einheit_Verbessern,
                                 Stadt_Bewachen, Verbesserung_Zerstören, Auf_Transporter_Warten);

   type Stadt_Aufgabe_Enum is (Keine_Aufgabe, Einheit_Bauen, Gebäude_Bauen, Gefahr_Einheit_Bauen);

   type Bewegung_Enum is (Belegt_Angriff, Unbelegt, Belegt_Kein_Angriff);

   -- Größe später besser anpassen.
   type BauenBewertung is range -500 .. 500;
   subtype BewegungBewertung is BauenBewertung range 0 .. 20;

   type NotAus is range 1 .. 100;
   subtype NotAusKlein is NotAus range 1 .. 5;

end KIDatentypen;
