pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard;

with SystemDatentypen;
with SystemRecords;
with TastenbelegungDatentypen;

package EingabeSFML is
   
   WelchesVorzeichen : Boolean;
   
   Frage : Positive;
   
   AktuellerWert : Natural;
      
   type TastenbelegungArray is array (1 .. 2, TastenbelegungDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
   Tastenbelegung : TastenbelegungArray;
   
   procedure StandardTastenbelegungLaden;
   
   

   function GanzeZahl
     (ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen;
      WelcheFrageExtern : in Positive)
      return SystemRecords.ZahlenEingabeRecord;
   
   function StadtName
     return SystemRecords.TextEingabeRecord;

   function SpielstandName
     return SystemRecords.TextEingabeRecord;

   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum;
   
private
   
   AktuelleZahl : Positive;
   
   ZahlenStringLeer : constant Wide_Wide_String (1 .. 10) := "0000000000";
   ZahlenString : Wide_Wide_String (1 .. 10);
   
   
   Zahlen : Sf.Window.Keyboard.sfKeyCode;
   Taste : Sf.Window.Keyboard.sfKeyCode;
   
   EingegebeneZahl : SystemRecords.ZahlenEingabeRecord;
   
   EingegebenerName : SystemRecords.TextEingabeRecord;
   Name : SystemRecords.TextEingabeRecord;
   
   type Zahl_Prüfung_Enum is (Zahl_Hinzufügen, Eingabe_Abbrechen, Eingabe_Fertig, Zahl_Löschen, Vorzeichen_Minus, Vorzeichen_Plus, Leer);
      
   type EingabeZahlenUmwandelnArray is array (Sf.Window.Keyboard.sfKeyNum0 .. Sf.Window.Keyboard.sfKeyNum9) of Wide_Wide_Character;
   EingabeZahlenUmwandeln : constant EingabeZahlenUmwandelnArray := (
                                                                     Sf.Window.Keyboard.sfKeyNum0 => '0',
                                                                     Sf.Window.Keyboard.sfKeyNum1 => '1',
                                                                     Sf.Window.Keyboard.sfKeyNum2 => '2',
                                                                     Sf.Window.Keyboard.sfKeyNum3 => '3',
                                                                     Sf.Window.Keyboard.sfKeyNum4 => '4',
                                                                     Sf.Window.Keyboard.sfKeyNum5 => '5',
                                                                     Sf.Window.Keyboard.sfKeyNum6 => '6',
                                                                     Sf.Window.Keyboard.sfKeyNum7 => '7',
                                                                     Sf.Window.Keyboard.sfKeyNum8 => '8',
                                                                     Sf.Window.Keyboard.sfKeyNum9 => '9'
                                                                    );
   
   TastenbelegungStandard : constant TastenbelegungArray := (
                                                             1 =>
                                                               (
                                                                TastenbelegungDatentypen.Oben_Enum                           => Sf.Window.Keyboard.sfKeyW,
                                                                TastenbelegungDatentypen.Links_Enum                          => Sf.Window.Keyboard.sfKeyA,
                                                                TastenbelegungDatentypen.Unten_Enum                          => Sf.Window.Keyboard.sfKeyS,
                                                                TastenbelegungDatentypen.Rechts_Enum                         => Sf.Window.Keyboard.sfKeyD,
                                                                TastenbelegungDatentypen.Links_Oben_Enum                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Rechts_Oben_Enum                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Links_Unten_Enum                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Rechts_Unten_Enum                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Ebene_Hoch_Enum                     => Sf.Window.Keyboard.sfKeyAdd,
                                                                TastenbelegungDatentypen.Ebene_Runter_Enum                   => Sf.Window.Keyboard.sfKeySubtract,

                                                                TastenbelegungDatentypen.Auswählen_Enum                      => Sf.Window.Keyboard.sfKeyE,
                                                                TastenbelegungDatentypen.Menü_Zurück_Enum                    => Sf.Window.Keyboard.sfKeyEscape,
                                                                TastenbelegungDatentypen.Bauen_Enum                          => Sf.Window.Keyboard.sfKeyB,
                                                                TastenbelegungDatentypen.Forschung_Enum                      => Sf.Window.Keyboard.sfKeyT,
                                                                TastenbelegungDatentypen.Tech_Baum_Enum                      => Sf.Window.Keyboard.sfKeyX,

                                                                TastenbelegungDatentypen.Nächste_Stadt_Enum                  => Sf.Window.Keyboard.sfKeySlash,
                                                                TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum    => Sf.Window.Keyboard.sfKeyPeriod,
                                                                TastenbelegungDatentypen.Alle_Einheiten_Enum                 => Sf.Window.Keyboard.sfKeyMultiply,
                                                                TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum => Sf.Window.Keyboard.sfKeyComma,
                                                                TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum      => Sf.Window.Keyboard.sfKeyNum0,
                                                                TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum    => Sf.Window.Keyboard.sfKeyO,

                                                                TastenbelegungDatentypen.Straße_Bauen_Enum                   => Sf.Window.Keyboard.sfKeyL,
                                                                TastenbelegungDatentypen.Mine_Bauen_Enum                     => Sf.Window.Keyboard.sfKeyM,
                                                                TastenbelegungDatentypen.Farm_Bauen_Enum                     => Sf.Window.Keyboard.sfKeyF,
                                                                TastenbelegungDatentypen.Festung_Bauen_Enum                  => Sf.Window.Keyboard.sfKeyU,
                                                                TastenbelegungDatentypen.Wald_Aufforsten_Enum                => Sf.Window.Keyboard.sfKeyZ,
                                                                TastenbelegungDatentypen.Roden_Trockenlegen_Enum             => Sf.Window.Keyboard.sfKeyP,
                                                                TastenbelegungDatentypen.Heilen_Enum                         => Sf.Window.Keyboard.sfKeyH,
                                                                TastenbelegungDatentypen.Verschanzen_Enum                    => Sf.Window.Keyboard.sfKeyV,
                                                                TastenbelegungDatentypen.Runde_Aussetzen_Enum                => Sf.Window.Keyboard.sfKeySpace,
                                                                TastenbelegungDatentypen.Auflösen_Enum                       => Sf.Window.Keyboard.sfKeyDelete,
                                                                TastenbelegungDatentypen.Plündern_Enum                       => Sf.Window.Keyboard.sfKeyJ,
                                                                TastenbelegungDatentypen.Heimatstadt_Ändern_Enum             => Sf.Window.Keyboard.sfKeyNum5,
                                                                TastenbelegungDatentypen.Einheit_Verbessern_Enum             => Sf.Window.Keyboard.sfKeyTab,
                                                                TastenbelegungDatentypen.Infos_Enum                          => Sf.Window.Keyboard.sfKeyI,

                                                                TastenbelegungDatentypen.Diplomatie_Enum                     => Sf.Window.Keyboard.sfKeyTilde,

                                                                TastenbelegungDatentypen.Gehe_Zu_Enum                        => Sf.Window.Keyboard.sfKeyG,

                                                                TastenbelegungDatentypen.Stadt_Umbenennen_Enum               => Sf.Window.Keyboard.sfKeyN,
                                                                TastenbelegungDatentypen.Stadt_Abreißen_Enum                 => Sf.Window.Keyboard.sfKeyK,
                                                                TastenbelegungDatentypen.Stadt_Suchen_Enum                   => Sf.Window.Keyboard.sfKeyY,

                                                                TastenbelegungDatentypen.Runde_Beenden_Enum                  => Sf.Window.Keyboard.sfKeyR,
                                                                TastenbelegungDatentypen.Debugmenü_Enum                      => Sf.Window.Keyboard.sfKeyC
                                                               ),

                                                             2 =>
                                                               (
                                                                TastenbelegungDatentypen.Oben_Enum                           => Sf.Window.Keyboard.sfKeyNum8,
                                                                TastenbelegungDatentypen.Links_Enum                          => Sf.Window.Keyboard.sfKeyNum4,
                                                                TastenbelegungDatentypen.Unten_Enum                          => Sf.Window.Keyboard.sfKeyNum2,
                                                                TastenbelegungDatentypen.Rechts_Enum                         => Sf.Window.Keyboard.sfKeyNum6,
                                                                TastenbelegungDatentypen.Links_Oben_Enum                     => Sf.Window.Keyboard.sfKeyNum7,
                                                                TastenbelegungDatentypen.Rechts_Oben_Enum                    => Sf.Window.Keyboard.sfKeyNum9,
                                                                TastenbelegungDatentypen.Links_Unten_Enum                    => Sf.Window.Keyboard.sfKeyNum1,
                                                                TastenbelegungDatentypen.Rechts_Unten_Enum                   => Sf.Window.Keyboard.sfKeyNum3,
                                                                TastenbelegungDatentypen.Ebene_Hoch_Enum                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Ebene_Runter_Enum                   => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungDatentypen.Auswählen_Enum                      => Sf.Window.Keyboard.sfKeyEnter,
                                                                TastenbelegungDatentypen.Menü_Zurück_Enum                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Bauen_Enum                          => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Forschung_Enum                      => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Tech_Baum_Enum                      => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungDatentypen.Nächste_Stadt_Enum                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Alle_Einheiten_Enum                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum      => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum    => Sf.Window.Keyboard.sfKeyUnknown,
 
                                                                TastenbelegungDatentypen.Straße_Bauen_Enum                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Mine_Bauen_Enum                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Farm_Bauen_Enum                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Festung_Bauen_Enum                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Wald_Aufforsten_Enum                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Roden_Trockenlegen_Enum             => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Heilen_Enum                         => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Verschanzen_Enum                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Runde_Aussetzen_Enum                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Auflösen_Enum                       => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Plündern_Enum                       => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Heimatstadt_Ändern_Enum             => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Einheit_Verbessern_Enum             => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Infos_Enum                          => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungDatentypen.Diplomatie_Enum                     => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungDatentypen.Gehe_Zu_Enum                        => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungDatentypen.Stadt_Umbenennen_Enum               => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Stadt_Abreißen_Enum                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Stadt_Suchen_Enum                   => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungDatentypen.Runde_Beenden_Enum                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungDatentypen.Debugmenü_Enum                      => Sf.Window.Keyboard.sfKeyUnknown
                                                               )
                                                            );
   
   procedure VorzeichenAnpassen
     (ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen;
      PlusMinusExtern : in Boolean);

   procedure ZahlHinzufügen
     (EingegebeneZahlExtern : in Sf.Window.Keyboard.sfKeyCode);

   procedure ZahlEntfernen;
   procedure EingabeAbwarten;
   
      
   
   function MinimumMaximumSetzen
     (ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen)
      return Boolean;
   
   function ZahlSchleife
     (ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen)
      return Boolean;
   
   function GanzeZahlPrüfung
     (ZeichenExtern : in Sf.Window.Keyboard.sfKeyCode)
      return Zahl_Prüfung_Enum;
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return SystemRecords.TextEingabeRecord;

end EingabeSFML;
