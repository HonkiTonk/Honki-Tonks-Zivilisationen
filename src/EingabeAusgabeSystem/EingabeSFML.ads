pragma SPARK_Mode (On);

with Sf.Window.Keyboard;

with SystemDatentypen;
with SystemRecords;

package EingabeSFML is
   
   WelchesVorzeichen : Boolean;
   
   Frage : Positive;
   
   AktuellerWert : Natural;
   
   subtype Grenzen is Integer range -1_000_000_000 .. 1_000_000_000;
   
   type TastenbelegungArray is array (1 .. 2, SystemDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
   Tastenbelegung : TastenbelegungArray;
   
   procedure WartenEingabe;
   procedure StandardTastenbelegungLaden;
   
   

   function GanzeZahl
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen;
      WelcheFrageExtern : in Positive)
      return SystemRecords.ZahlenEingabeRecord;
   
   function StadtName
     return SystemRecords.TextEingabeRecord;

   function SpielstandName
     return SystemRecords.TextEingabeRecord;

   function Tastenwert
     return SystemDatentypen.Tastenbelegung_Enum;
   
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
                                                                SystemDatentypen.Oben                           => Sf.Window.Keyboard.sfKeyW,
                                                                SystemDatentypen.Links                          => Sf.Window.Keyboard.sfKeyA,
                                                                SystemDatentypen.Unten                          => Sf.Window.Keyboard.sfKeyS,
                                                                SystemDatentypen.Rechts                         => Sf.Window.Keyboard.sfKeyD,
                                                                SystemDatentypen.Links_Oben                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Rechts_Oben                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Links_Unten                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Rechts_Unten                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Ebene_Hoch                     => Sf.Window.Keyboard.sfKeyAdd,
                                                                SystemDatentypen.Ebene_Runter                   => Sf.Window.Keyboard.sfKeySubtract,

                                                                SystemDatentypen.Auswählen                      => Sf.Window.Keyboard.sfKeyE,
                                                                SystemDatentypen.Menü_Zurück                    => Sf.Window.Keyboard.sfKeyQ,
                                                                SystemDatentypen.Bauen                          => Sf.Window.Keyboard.sfKeyB,
                                                                SystemDatentypen.Forschung                      => Sf.Window.Keyboard.sfKeyT,
                                                                SystemDatentypen.Tech_Baum                      => Sf.Window.Keyboard.sfKeyX,

                                                                SystemDatentypen.Nächste_Stadt                  => Sf.Window.Keyboard.sfKeySlash,
                                                                SystemDatentypen.Einheit_Mit_Bewegungspunkte    => Sf.Window.Keyboard.sfKeyPeriod,
                                                                SystemDatentypen.Alle_Einheiten                 => Sf.Window.Keyboard.sfKeyMultiply,
                                                                SystemDatentypen.Einheiten_Ohne_Bewegungspunkte => Sf.Window.Keyboard.sfKeyComma,
                                                                SystemDatentypen.Nächste_Stadt_Mit_Meldung      => Sf.Window.Keyboard.sfKeyNum0,
                                                                SystemDatentypen.Nächste_Einheit_Mit_Meldung    => Sf.Window.Keyboard.sfKeyO,

                                                                SystemDatentypen.Straße_Bauen                   => Sf.Window.Keyboard.sfKeyL,
                                                                SystemDatentypen.Mine_Bauen                     => Sf.Window.Keyboard.sfKeyM,
                                                                SystemDatentypen.Farm_Bauen                     => Sf.Window.Keyboard.sfKeyF,
                                                                SystemDatentypen.Festung_Bauen                  => Sf.Window.Keyboard.sfKeyU,
                                                                SystemDatentypen.Wald_Aufforsten                => Sf.Window.Keyboard.sfKeyZ,
                                                                SystemDatentypen.Roden_Trockenlegen             => Sf.Window.Keyboard.sfKeyP,
                                                                SystemDatentypen.Heilen                         => Sf.Window.Keyboard.sfKeyH,
                                                                SystemDatentypen.Verschanzen                    => Sf.Window.Keyboard.sfKeyV,
                                                                SystemDatentypen.Runde_Aussetzen                => Sf.Window.Keyboard.sfKeySpace,
                                                                SystemDatentypen.Einheit_Auflösen               => Sf.Window.Keyboard.sfKeyDelete,
                                                                SystemDatentypen.Plündern                       => Sf.Window.Keyboard.sfKeyJ,
                                                                SystemDatentypen.Heimatstadt_Ändern             => Sf.Window.Keyboard.sfKeyNum5,
                                                                SystemDatentypen.Einheit_Verbessern             => Sf.Window.Keyboard.sfKeyTab,
                                                                SystemDatentypen.Infos                          => Sf.Window.Keyboard.sfKeyI,

                                                                SystemDatentypen.Diplomatie                     => Sf.Window.Keyboard.sfKeyTilde,

                                                                SystemDatentypen.GeheZu                         => Sf.Window.Keyboard.sfKeyG,

                                                                SystemDatentypen.Stadt_Umbenennen               => Sf.Window.Keyboard.sfKeyN,
                                                                SystemDatentypen.Stadt_Abreißen                 => Sf.Window.Keyboard.sfKeyK,
                                                                SystemDatentypen.Stadt_Suchen                   => Sf.Window.Keyboard.sfKeyY,

                                                                SystemDatentypen.Runde_Beenden                  => Sf.Window.Keyboard.sfKeyR,
                                                                SystemDatentypen.Cheatmenü                      => Sf.Window.Keyboard.sfKeyC
                                                               ),

                                                             2 =>
                                                               (
                                                                SystemDatentypen.Oben                           => Sf.Window.Keyboard.sfKeyNum8,
                                                                SystemDatentypen.Links                          => Sf.Window.Keyboard.sfKeyNum4,
                                                                SystemDatentypen.Unten                          => Sf.Window.Keyboard.sfKeyNum2,
                                                                SystemDatentypen.Rechts                         => Sf.Window.Keyboard.sfKeyNum6,
                                                                SystemDatentypen.Links_Oben                     => Sf.Window.Keyboard.sfKeyNum7,
                                                                SystemDatentypen.Rechts_Oben                    => Sf.Window.Keyboard.sfKeyNum9,
                                                                SystemDatentypen.Links_Unten                    => Sf.Window.Keyboard.sfKeyNum1,
                                                                SystemDatentypen.Rechts_Unten                   => Sf.Window.Keyboard.sfKeyNum3,
                                                                SystemDatentypen.Ebene_Hoch                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Ebene_Runter                   => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemDatentypen.Auswählen                      => Sf.Window.Keyboard.sfKeyEnter,
                                                                SystemDatentypen.Menü_Zurück                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Bauen                          => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Forschung                      => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Tech_Baum                      => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemDatentypen.Nächste_Stadt                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Einheit_Mit_Bewegungspunkte    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Alle_Einheiten                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Einheiten_Ohne_Bewegungspunkte => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Nächste_Stadt_Mit_Meldung      => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Nächste_Einheit_Mit_Meldung    => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemDatentypen.Straße_Bauen                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Mine_Bauen                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Farm_Bauen                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Festung_Bauen                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Wald_Aufforsten                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Roden_Trockenlegen             => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Heilen                         => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Verschanzen                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Runde_Aussetzen                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Einheit_Auflösen               => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Plündern                       => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Heimatstadt_Ändern             => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Einheit_Verbessern             => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Infos                          => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemDatentypen.Diplomatie                     => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemDatentypen.GeheZu                         => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemDatentypen.Stadt_Umbenennen               => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Stadt_Abreißen                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Stadt_Suchen                   => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemDatentypen.Runde_Beenden                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemDatentypen.Cheatmenü                      => Sf.Window.Keyboard.sfKeyUnknown
                                                               )
                                                            );
   
   procedure VorzeichenAnpassen
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen;
      PlusMinusExtern : in Boolean);

   procedure ZahlHinzufügen
     (EingegebeneZahlExtern : in Sf.Window.Keyboard.sfKeyCode);

   procedure ZahlEntfernen;
   
      
   
   function MinimumMaximumSetzen
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen)
      return Boolean;
   
   function ZahlSchleife
     (ZahlenMinimumExtern : in Grenzen;
      ZahlenMaximumExtern : in Grenzen)
      return Boolean;
   
   function GanzeZahlPrüfung
     (ZeichenExtern : in Sf.Window.Keyboard.sfKeyCode)
      return Zahl_Prüfung_Enum;
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return SystemRecords.TextEingabeRecord;

end EingabeSFML;
