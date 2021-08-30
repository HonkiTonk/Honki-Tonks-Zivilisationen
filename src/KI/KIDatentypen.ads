pragma SPARK_Mode (On);

package KIDatentypen is

   type Einheit_Aufgabe_Enum is (Keine_Aufgabe, Stadt_Bauen, Flucht, Erkunden, Verbesserung_Anlegen, Angreifen, Verteidigen, Einheit_Heilen, Einheit_Auflösen, Einheit_Festsetzen, Einheit_Verbessern,
                                 Stadt_Bewachen, Verbesserung_Zerstören, Auf_Transporter_Warten);

   type Stadt_Aufgabe_Enum is (Keine_Aufgabe, Einheit_Bauen, Gebäude_Bauen, Gefahr_Einheit_Bauen);

end KIDatentypen;
