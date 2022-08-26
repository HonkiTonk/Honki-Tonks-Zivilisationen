pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard;

with TastenbelegungDatentypen;

package TastenbelegungVariablen is
   
   type TastenbelegungArray is array (TastenbelegungDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
   Tastenbelegung : TastenbelegungArray;
   
   procedure StandardTastenbelegungLaden;
   
private
   
   TastenbelegungStandard : constant TastenbelegungArray := (
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

                                                             TastenbelegungDatentypen.Menü_Zurück_Enum                    => Sf.Window.Keyboard.sfKeyEscape,
                                                             
                                                                                                                                
                                                                                                                                
                                                             TastenbelegungDatentypen.Bauen_Enum                          => Sf.Window.Keyboard.sfKeyB,
                                                             TastenbelegungDatentypen.Forschung_Enum                      => Sf.Window.Keyboard.sfKeyT,
                                                                
                                                             TastenbelegungDatentypen.Nächste_Stadt_Enum                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                             TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum    => Sf.Window.Keyboard.sfKeyUnknown,
                                                             TastenbelegungDatentypen.Alle_Einheiten_Enum                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                             TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum => Sf.Window.Keyboard.sfKeyUnknown,
                                                             TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum      => Sf.Window.Keyboard.sfKeyUnknown,
                                                             TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum    => Sf.Window.Keyboard.sfKeyO,
                                                                
                                                             TastenbelegungDatentypen.Straße_Bauen_Enum                   => Sf.Window.Keyboard.sfKeyL,
                                                             TastenbelegungDatentypen.Mine_Bauen_Enum                     => Sf.Window.Keyboard.sfKeyM,
                                                             TastenbelegungDatentypen.Farm_Bauen_Enum                     => Sf.Window.Keyboard.sfKeyF,
                                                             TastenbelegungDatentypen.Festung_Bauen_Enum                  => Sf.Window.Keyboard.sfKeyU,
                                                             TastenbelegungDatentypen.Wald_Aufforsten_Enum                => Sf.Window.Keyboard.sfKeyZ,
                                                             TastenbelegungDatentypen.Roden_Trockenlegen_Enum             => Sf.Window.Keyboard.sfKeyP,

                                                             TastenbelegungDatentypen.Heilen_Enum                         => Sf.Window.Keyboard.sfKeyH,
                                                             TastenbelegungDatentypen.Verschanzen_Enum                    => Sf.Window.Keyboard.sfKeyV,
                                                             TastenbelegungDatentypen.Plündern_Enum                       => Sf.Window.Keyboard.sfKeyJ,
                                                             TastenbelegungDatentypen.Auflösen_Enum                       => Sf.Window.Keyboard.sfKeyK,
                                                             TastenbelegungDatentypen.Einheit_Verbessern_Enum             => Sf.Window.Keyboard.sfKeyA,
                                                             TastenbelegungDatentypen.Heimatstadt_Ändern_Enum             => Sf.Window.Keyboard.sfKeyC,

                                                             TastenbelegungDatentypen.Diplomatie_Enum                     => Sf.Window.Keyboard.sfKeyD,
                                                             TastenbelegungDatentypen.Gehe_Zu_Enum                        => Sf.Window.Keyboard.sfKeyG,

                                                             TastenbelegungDatentypen.Stadt_Umbenennen_Enum               => Sf.Window.Keyboard.sfKeyN,
                                                             TastenbelegungDatentypen.Stadt_Suchen_Enum                   => Sf.Window.Keyboard.sfKeyY,

                                                             TastenbelegungDatentypen.Runde_Beenden_Enum                  => Sf.Window.Keyboard.sfKeyR,
                                                                
                                                                
                                                                
                                                             TastenbelegungDatentypen.Debugmenü_Enum                      => Sf.Window.Keyboard.sfKeyPause,
                                                             TastenbelegungDatentypen.Auswählen_Enum                      => Sf.Window.Keyboard.sfKeyUnknown
                                                            );
   
end TastenbelegungVariablen;
