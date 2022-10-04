pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package TastenbelegungDatentypen is
   
   -- Beim Überarbeiten des Steuerungsmenüs das hier auch gleich neu sortieren. äöü
   type Allgemeine_Belegung_Enum is (
                                     Leer_Allgemeine_Belegung_Enum,
                                     
                                     Auswählen_Enum,
                                
                                     -- Bewegung
                                     Oben_Enum, Links_Enum, Unten_Enum, Rechts_Enum, Links_Oben_Enum, Rechts_Oben_Enum, Links_Unten_Enum, Rechts_Unten_Enum,
                                     Ebene_Hoch_Enum, Ebene_Runter_Enum,
                                
                                     -- Ab hier auswählbar.
                                     Forschung_Enum,
                                
                                     Nächste_Stadt_Enum, Einheit_Mit_Bewegungspunkte_Enum, Alle_Einheiten_Enum, Einheiten_Ohne_Bewegungspunkte_Enum, Nächste_Stadt_Mit_Meldung_Enum, Nächste_Einheit_Mit_Meldung_Enum,
                                
                                     -- Sonstiges
                                     Diplomatie_Enum, Gehe_Zu_Enum,
                                
                                     -- Stadt
                                     Stadt_Suchen_Enum,
                                
                                     Runde_Beenden_Enum,
                                
                                     Abwählen_Enum, Debugmenü_Enum
                                    );
   
   subtype Allgemeine_Belegung_Vorhanden_Enum is Allgemeine_Belegung_Enum range Auswählen_Enum .. Allgemeine_Belegung_Enum'Last;
   
   subtype Tastenbelegung_Bewegung_Enum is Allgemeine_Belegung_Vorhanden_Enum range Oben_Enum .. Ebene_Runter_Enum;
   
   subtype Weltkartenbefehle_Enum is Allgemeine_Belegung_Enum range Allgemeine_Belegung_Enum'First .. Runde_Beenden_Enum;
   subtype Kartenbefehle_Enum is Weltkartenbefehle_Enum range Forschung_Enum .. Runde_Beenden_Enum;
   
end TastenbelegungDatentypen;
