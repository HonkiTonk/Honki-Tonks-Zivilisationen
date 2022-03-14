pragma SPARK_Mode (On);

package TastenbelegungDatentypen is

   ------------------ Raus- und reinzoomen einbauen.
   type Tastenbelegung_Enum is (Leer_Tastenbelegung,
                                
                                -- Bewegung
                                Oben, Links, Unten, Rechts, Links_Oben, Rechts_Oben, Links_Unten, Rechts_Unten, Ebene_Hoch, Ebene_Runter,
                                
                                Auswählen, Menü_Zurück, Bauen, Forschung, Tech_Baum,
                                
                                Nächste_Stadt, Einheit_Mit_Bewegungspunkte, Alle_Einheiten, Einheiten_Ohne_Bewegungspunkte, Nächste_Stadt_Mit_Meldung, Nächste_Einheit_Mit_Meldung,
                                
                                -- Einheitenbefehle Verbesserungen
                                Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen,
                                
                                -- Einheitenbefehle allgemein
                                Heilen, Verschanzen, Runde_Aussetzen, Plündern, Auflösen, Einheit_Verbessern,
                                Heimatstadt_Ändern,
                                
                                -- Sonstiges
                                Infos, Diplomatie, GeheZu,
                                Stadt_Umbenennen, Stadt_Abreißen, Stadt_Suchen,
                                Runde_Beenden, Debugmenü);

   subtype Tastenbelegung_Verwendet_Enum is Tastenbelegung_Enum range Oben .. Tastenbelegung_Enum'Last;
   subtype Tastenbelegung_Bewegung_Enum is Tastenbelegung_Verwendet_Enum range Oben .. Ebene_Runter;
   subtype Tastenbelegung_Bewegung_Stadt_Enum is Tastenbelegung_Verwendet_Enum range Oben .. Rechts_Unten;
   subtype Tastenbelegung_Befehle_Enum is Tastenbelegung_Verwendet_Enum range Straße_Bauen .. Einheit_Verbessern;
   subtype Tastenbelegung_Befehle_Anzeige is Tastenbelegung_Befehle_Enum range Straße_Bauen .. Verschanzen;
   subtype Tastenbelegung_Verbesserung_Befehle_Enum is Tastenbelegung_Befehle_Enum range Straße_Bauen .. Roden_Trockenlegen;
   subtype Tastenbelegung_Allgemeine_Befehle_Enum is Tastenbelegung_Befehle_Enum range Heilen .. Tastenbelegung_Befehle_Enum'Last;

end TastenbelegungDatentypen;
