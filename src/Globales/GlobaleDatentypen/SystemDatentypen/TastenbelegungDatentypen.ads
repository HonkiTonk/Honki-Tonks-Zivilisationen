pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package TastenbelegungDatentypen is
   
   type Allgemeine_Belegung_Enum is (
                                     Leer_Allgemeine_Belegung_Enum,
                                     
                                     Auswählen_Enum,
                                
                                     -- Bewegung
                                     Oben_Enum, Links_Enum, Unten_Enum, Rechts_Enum, Links_Oben_Enum, Rechts_Oben_Enum, Links_Unten_Enum, Rechts_Unten_Enum,
                                     Ebene_Hoch_Enum, Ebene_Runter_Enum,
                                
                                     -- Menüs
                                     Forschung_Enum,
                                     Diplomatie_Enum,
                                
                                     -- Stadt
                                     Stadt_Suchen_Enum,
                                     Nächste_Stadt_Enum, Nächste_Stadt_Mit_Meldung_Enum,
                                     
                                     -- Einheit
                                     Nächste_Einheit_Enum, Nächste_Einheit_Mit_Meldung_Enum,
                                     Einheit_Mit_Bewegungspunkte_Enum, Einheiten_Ohne_Bewegungspunkte_Enum,
                                     
                                     -- Sonstiges
                                     Gehe_Zu_Enum,
                                     Runde_Beenden_Enum,
                                     
                                     Abwählen_Enum,
                                     
                                     Debugmenü_Enum
                                    );
   
   subtype Allgemeine_Belegung_Vorhanden_Enum is Allgemeine_Belegung_Enum range Auswählen_Enum .. Allgemeine_Belegung_Enum'Last;
   
   subtype Tastenbelegung_Bewegung_Erweitert_Enum is Allgemeine_Belegung_Vorhanden_Enum range Auswählen_Enum .. Ebene_Runter_Enum;
   subtype Tastenbelegung_Bewegung_Enum is Tastenbelegung_Bewegung_Erweitert_Enum range Oben_Enum .. Tastenbelegung_Bewegung_Erweitert_Enum'Last;
   
   subtype Weltkartenbefehle_Enum is Allgemeine_Belegung_Enum range Allgemeine_Belegung_Enum'First .. Runde_Beenden_Enum;
   subtype Kartenbefehle_Enum is Weltkartenbefehle_Enum range Forschung_Enum .. Runde_Beenden_Enum;
   
end TastenbelegungDatentypen;
