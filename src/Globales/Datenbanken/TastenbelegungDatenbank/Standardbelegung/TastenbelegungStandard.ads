with Sf.Window.Keyboard;

with TastenbelegungDatenbank;
with TastenbelegungDatentypen;
with BefehleDatentypen;

package TastenbelegungStandard is
   pragma Elaborate_Body;

   AllgemeineBelegungStandard : constant TastenbelegungDatenbank.AllgemeineBelegungArray := (
                                                                                             TastenbelegungDatentypen.Auswählen_Enum                      => Sf.Window.Keyboard.sfKeyUnknown,
                                                                                             -- Hier noch einen Wert für die rechte Maustaste einbauen und da dann Informationen auf der Karten anzeigen? äöü
                                                                                             -- Eventuell lassen dafür weitere Nutzungsmöglichkeiten finden? äöü
                                                                     
                                                                                             -- Bewegung
                                                                                             TastenbelegungDatentypen.Oben_Enum                           => Sf.Window.Keyboard.sfKeyNumpad8,
                                                                                             TastenbelegungDatentypen.Links_Enum                          => Sf.Window.Keyboard.sfKeyNumpad4,
                                                                                             TastenbelegungDatentypen.Unten_Enum                          => Sf.Window.Keyboard.sfKeyNumpad2,
                                                                                             TastenbelegungDatentypen.Rechts_Enum                         => Sf.Window.Keyboard.sfKeyNumpad6,
                                                                                             TastenbelegungDatentypen.Links_Oben_Enum                     => Sf.Window.Keyboard.sfKeyNumpad7,
                                                                                             TastenbelegungDatentypen.Rechts_Oben_Enum                    => Sf.Window.Keyboard.sfKeyNumpad9,
                                                                                             TastenbelegungDatentypen.Links_Unten_Enum                    => Sf.Window.Keyboard.sfKeyNumpad1,
                                                                                             TastenbelegungDatentypen.Rechts_Unten_Enum                   => Sf.Window.Keyboard.sfKeyNumpad3,
                                                                                             TastenbelegungDatentypen.Ebene_Hoch_Enum                     => Sf.Window.Keyboard.sfKeyAdd,
                                                                                             TastenbelegungDatentypen.Ebene_Runter_Enum                   => Sf.Window.Keyboard.sfKeySubtract,
                                
                                                                                             -- Menüs
                                                                                             TastenbelegungDatentypen.Forschung_Enum                      => Sf.Window.Keyboard.sfKeyF,
                                                                                             TastenbelegungDatentypen.Diplomatie_Enum                     => Sf.Window.Keyboard.sfKeyD,
                                                                
                                                                                             -- Stadt
                                                                                             TastenbelegungDatentypen.Stadt_Suchen_Enum                   => Sf.Window.Keyboard.sfKeyS,
                                                                                             TastenbelegungDatentypen.Nächste_Stadt_Enum                  => Sf.Window.Keyboard.sfKeyPageUp,
                                                                                             TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum      => Sf.Window.Keyboard.sfKeyPageDown,
                                                                     
                                                                                             -- Einheit
                                                                                             TastenbelegungDatentypen.Nächste_Einheit_Enum                => Sf.Window.Keyboard.sfKeyE,
                                                                                             TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum    => Sf.Window.Keyboard.sfKeyO,
                                                                                             TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum    => Sf.Window.Keyboard.sfKeyB,
                                                                                             TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum => Sf.Window.Keyboard.sfKeyP,
                                                                     
                                                                                             -- Sonstiges
                                                                                             TastenbelegungDatentypen.Gehe_Zu_Enum                        => Sf.Window.Keyboard.sfKeyG,
                                                                                             TastenbelegungDatentypen.Runde_Beenden_Enum                  => Sf.Window.Keyboard.sfKeyR,
                                                                     
                                                                                             TastenbelegungDatentypen.Debugmenü_Enum                      => Sf.Window.Keyboard.sfKeyPause,
                                                                     
                                                                                             TastenbelegungDatentypen.Abwählen_Enum                       => Sf.Window.Keyboard.sfKeyEscape
                                                                                            );
   
   
   
   EinheitenbelegungStandard : constant TastenbelegungDatenbank.EinheitenbelegungArray := (
                                                                                           BefehleDatentypen.Auswählen_Enum             => Sf.Window.Keyboard.sfKeyUnknown,
                                
                                                                                           -- Bewegung
                                                                                           BefehleDatentypen.Oben_Enum                  => Sf.Window.Keyboard.sfKeyNumpad8,
                                                                                           BefehleDatentypen.Links_Enum                 => Sf.Window.Keyboard.sfKeyNumpad4,
                                                                                           BefehleDatentypen.Unten_Enum                 => Sf.Window.Keyboard.sfKeyNumpad2,
                                                                                           BefehleDatentypen.Rechts_Enum                => Sf.Window.Keyboard.sfKeyNumpad6,
                                                                                           BefehleDatentypen.Links_Oben_Enum            => Sf.Window.Keyboard.sfKeyNumpad7,
                                                                                           BefehleDatentypen.Rechts_Oben_Enum           => Sf.Window.Keyboard.sfKeyNumpad9,
                                                                                           BefehleDatentypen.Links_Unten_Enum           => Sf.Window.Keyboard.sfKeyNumpad1,
                                                                                           BefehleDatentypen.Rechts_Unten_Enum          => Sf.Window.Keyboard.sfKeyNumpad3,
                                                                                           BefehleDatentypen.Ebene_Hoch_Enum            => Sf.Window.Keyboard.sfKeyAdd,
                                                                                           BefehleDatentypen.Ebene_Runter_Enum          => Sf.Window.Keyboard.sfKeySubtract,
                                
                                                                                           -- Einheitenbefehle Verbesserungen
                                                                                           BefehleDatentypen.Bauen_Enum                 => Sf.Window.Keyboard.sfKeyB,
                                                                
                                                                                           BefehleDatentypen.Straße_Bauen_Enum          => Sf.Window.Keyboard.sfKeyL,
                                                                                           BefehleDatentypen.Mine_Bauen_Enum            => Sf.Window.Keyboard.sfKeyM,
                                                                                           BefehleDatentypen.Farm_Bauen_Enum            => Sf.Window.Keyboard.sfKeyF,
                                                                                           BefehleDatentypen.Festung_Bauen_Enum         => Sf.Window.Keyboard.sfKeyS,
                                                                                           BefehleDatentypen.Wald_Aufforsten_Enum       => Sf.Window.Keyboard.sfKeyW,
                                                                                           BefehleDatentypen.Roden_Trockenlegen_Enum    => Sf.Window.Keyboard.sfKeyR,
                                                                                           
                                                                                           BefehleDatentypen.Feldeffekte_Entfernen_Enum => Sf.Window.Keyboard.sfKeyT,
                                                                                           -- Strahlung_Entfernen_Enum, Biologisch_Entfernen_Enum, Chemisch_Entfernen_Enum, Verschmutzung_Entfernen_Enum,
                                                                   
                                                                                           -- Einheitenbefehle Allgemein
                                                                                           BefehleDatentypen.Heilen_Enum                => Sf.Window.Keyboard.sfKeyH,
                                                                                           BefehleDatentypen.Verschanzen_Enum           => Sf.Window.Keyboard.sfKeyV,
                                                                                           BefehleDatentypen.Plündern_Enum              => Sf.Window.Keyboard.sfKeyP,
                                                                                           BefehleDatentypen.Auflösen_Enum              => Sf.Window.Keyboard.sfKeyA,
                                                                                           BefehleDatentypen.Einheit_Verbessern_Enum    => Sf.Window.Keyboard.sfKeyU,
                                                                                           BefehleDatentypen.Heimatstadt_Ändern_Enum    => Sf.Window.Keyboard.sfKeyC,
                                                                                           BefehleDatentypen.Entladen_Enum              => Sf.Window.Keyboard.sfKeyE,
                                   
                                                                                           BefehleDatentypen.Abwählen_Enum              => Sf.Window.Keyboard.sfKeyEscape
                                                                                          );
   
   
   
   StadtbelegungStandard : constant TastenbelegungDatenbank.StadtbelegungArray := (
                                                                                   BefehleDatentypen.Stadtkarte_Enum => Sf.Window.Keyboard.sfKeyK,
                                                                                   BefehleDatentypen.Bauen_Enum      => Sf.Window.Keyboard.sfKeyB,
                                                                                   BefehleDatentypen.Verkaufen_Enum  => Sf.Window.Keyboard.sfKeyV,
                                                                                   BefehleDatentypen.Umbenennen_Enum => Sf.Window.Keyboard.sfKeyU,
                                                                                   BefehleDatentypen.Auflösen_Enum   => Sf.Window.Keyboard.sfKeyA,
                                                                                   BefehleDatentypen.Verlassen_Enum  => Sf.Window.Keyboard.sfKeyEscape
                                                                                  );

end TastenbelegungStandard;
