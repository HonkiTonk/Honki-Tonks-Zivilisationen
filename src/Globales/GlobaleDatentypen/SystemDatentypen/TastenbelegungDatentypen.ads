pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package TastenbelegungDatentypen is

   -- Wenn ich bestimmte Einheitenbefehle nur noch bei ausgewählten Einheiten zulasse, müsste ich das hier dann nicht in zwei unabhängige Teile aufteilen können? äöü
   type Tastenbelegung_Enum is (
                                Leer_Tastenbelegung_Enum,
                                
                                Auswählen_Enum,
                                
                                -- Bewegung
                                Oben_Enum, Links_Enum, Unten_Enum, Rechts_Enum, Links_Oben_Enum, Rechts_Oben_Enum, Links_Unten_Enum, Rechts_Unten_Enum, Ebene_Hoch_Enum, Ebene_Runter_Enum,
                                
                                -- Einheitenbefehle Verbesserungen
                                Bauen_Enum,
                                
                                Straße_Bauen_Enum,
                                Mine_Bauen_Enum, Farm_Bauen_Enum, Festung_Bauen_Enum,
                                Wald_Aufforsten_Enum, Roden_Trockenlegen_Enum,
                                
                                -- Einheitenbefehle allgemein
                                Heilen_Enum, Verschanzen_Enum, Plündern_Enum, Auflösen_Enum, Einheit_Verbessern_Enum,
                                Heimatstadt_Ändern_Enum, Entladen_Enum,
                                
                                -- Ab hier auswählbar.
                                Forschung_Enum,
                                
                                Nächste_Stadt_Enum, Einheit_Mit_Bewegungspunkte_Enum, Alle_Einheiten_Enum, Einheiten_Ohne_Bewegungspunkte_Enum, Nächste_Stadt_Mit_Meldung_Enum, Nächste_Einheit_Mit_Meldung_Enum,
                                
                                -- Sonstiges
                                Diplomatie_Enum, Gehe_Zu_Enum,
                                
                                -- Stadt
                                Stadt_Umbenennen_Enum, Stadt_Suchen_Enum,
                                
                                Runde_Beenden_Enum,
                                
                                Menü_Zurück_Enum, Debugmenü_Enum
                               );
   
   pragma Ordered (Tastenbelegung_Enum);

   subtype Tastenbelegung_Verwendet_Enum is Tastenbelegung_Enum range Auswählen_Enum .. Tastenbelegung_Enum'Last;
   
   subtype Tastenbelegung_Auswählbar_Enum is Tastenbelegung_Verwendet_Enum range Bauen_Enum .. Runde_Beenden_Enum;
   
   subtype Tastenbelegung_Bewegung_Enum is Tastenbelegung_Verwendet_Enum range Oben_Enum .. Ebene_Runter_Enum;
   subtype Tastenbelegung_Bewegung_Numblock_Enum is Tastenbelegung_Bewegung_Enum range Oben_Enum .. Rechts_Unten_Enum;
   subtype Tastenbelegung_Bewegung_Ebene_Enum is Tastenbelegung_Bewegung_Enum range Ebene_Hoch_Enum .. Ebene_Runter_Enum;
   
   subtype Tastenbelegung_Befehle_Enum is Tastenbelegung_Verwendet_Enum range Bauen_Enum .. Einheit_Verbessern_Enum;
   subtype Tastenbelegung_Befehle_Baulos_Enum is Tastenbelegung_Befehle_Enum range Straße_Bauen_Enum .. Einheit_Verbessern_Enum;
   subtype Tastenbelegung_Verbesserung_Befehle_Enum is Tastenbelegung_Befehle_Enum range Straße_Bauen_Enum .. Roden_Trockenlegen_Enum;
   
   -- subtype Tastenbelegung_Straße_Enum is Tastenbelegung_Verbesserung_Befehle_Enum range Straße_Bauen_Enum .. Straße_Bauen_Enum;
   -- subtype Tastenbelegung_Verbesserung_Enum is Tastenbelegung_Verbesserung_Befehle_Enum range Mine_Bauen_Enum .. Tastenbelegung_Verbesserung_Befehle_Enum'Last;
   subtype Tastenbelegung_Konstruktionen_Enum is Tastenbelegung_Verbesserung_Befehle_Enum range Mine_Bauen_Enum .. Festung_Bauen_Enum;
   -- subtype Tastenbelegung_Grundbearbeitung_Enum is Tastenbelegung_Verbesserung_Enum range Wald_Aufforsten_Enum .. Roden_Trockenlegen_Enum;
   
   subtype Tastenbelegung_Allgemeine_Befehle_Enum is Tastenbelegung_Befehle_Enum range Heilen_Enum .. Tastenbelegung_Befehle_Enum'Last;
   
end TastenbelegungDatentypen;
