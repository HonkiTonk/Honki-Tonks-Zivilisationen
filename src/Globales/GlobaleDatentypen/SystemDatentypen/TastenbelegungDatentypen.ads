pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package TastenbelegungDatentypen is

   -- Raus- und reinzoomen einbauen. äöü
   type Tastenbelegung_Enum is (
                                Leer_Tastenbelegung_Enum,
                                
                                -- Bewegung
                                Oben_Enum, Links_Enum, Unten_Enum, Rechts_Enum, Links_Oben_Enum, Rechts_Oben_Enum, Links_Unten_Enum, Rechts_Unten_Enum, Ebene_Hoch_Enum, Ebene_Runter_Enum,
                                
                                Auswählen_Enum, Menü_Zurück_Enum, Bauen_Enum, Forschung_Enum, Tech_Baum_Enum,
                                
                                Nächste_Stadt_Enum, Einheit_Mit_Bewegungspunkte_Enum, Alle_Einheiten_Enum, Einheiten_Ohne_Bewegungspunkte_Enum, Nächste_Stadt_Mit_Meldung_Enum, Nächste_Einheit_Mit_Meldung_Enum,
                                
                                -- Einheitenbefehle Verbesserungen
                                Straße_Bauen_Enum,
                                Mine_Bauen_Enum, Farm_Bauen_Enum, Festung_Bauen_Enum,
                                Wald_Aufforsten_Enum, Roden_Trockenlegen_Enum,
                                
                                -- Einheitenbefehle allgemein
                                Heilen_Enum, Verschanzen_Enum, Runde_Aussetzen_Enum, Plündern_Enum, Auflösen_Enum, Einheit_Verbessern_Enum, Heimatstadt_Ändern_Enum,
                                
                                -- Sonstiges
                                Infos_Enum, Diplomatie_Enum, Gehe_Zu_Enum, Stadt_Umbenennen_Enum, Stadt_Abreißen_Enum, Stadt_Suchen_Enum, Runde_Beenden_Enum, Debugmenü_Enum
                               );

   subtype Tastenbelegung_Verwendet_Enum is Tastenbelegung_Enum range Oben_Enum .. Tastenbelegung_Enum'Last;
   subtype Tastenbelegung_Bewegung_Enum is Tastenbelegung_Verwendet_Enum range Oben_Enum .. Ebene_Runter_Enum;
   subtype Tastenbelegung_Bewegung_Stadt_Enum is Tastenbelegung_Verwendet_Enum range Oben_Enum .. Rechts_Unten_Enum;
   subtype Tastenbelegung_Befehle_Enum is Tastenbelegung_Verwendet_Enum range Straße_Bauen_Enum .. Einheit_Verbessern_Enum;
   subtype Tastenbelegung_Befehle_Anzeige is Tastenbelegung_Befehle_Enum range Straße_Bauen_Enum .. Verschanzen_Enum;
   subtype Tastenbelegung_Verbesserung_Befehle_Enum is Tastenbelegung_Befehle_Enum range Straße_Bauen_Enum .. Roden_Trockenlegen_Enum;
   
   subtype Tastenbelegung_Straße_Enum is Tastenbelegung_Verbesserung_Befehle_Enum range Straße_Bauen_Enum .. Straße_Bauen_Enum;
   subtype Tastenbelegung_Verbesserung_Enum is Tastenbelegung_Verbesserung_Befehle_Enum range Mine_Bauen_Enum .. Tastenbelegung_Verbesserung_Befehle_Enum'Last;
   subtype Tastenbelegung_Konstruktionen_Enum is Tastenbelegung_Verbesserung_Enum range Mine_Bauen_Enum .. Festung_Bauen_Enum;
   subtype Tastenbelegung_Grundbearbeitung_Enum is Tastenbelegung_Verbesserung_Enum range Wald_Aufforsten_Enum .. Roden_Trockenlegen_Enum;
   
   subtype Tastenbelegung_Allgemeine_Befehle_Enum is Tastenbelegung_Befehle_Enum range Heilen_Enum .. Tastenbelegung_Befehle_Enum'Last;
   
end TastenbelegungDatentypen;
