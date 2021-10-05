pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Window.Keyboard, Sf.Window.Event;
use Sf.Window.Keyboard, Sf.Window.Event;

with SystemDatentypen, GlobaleTexte, KartenDatentypen;
use SystemDatentypen, KartenDatentypen;

package Eingabe is

   type TastenbelegungArray is array (1 .. 2, SystemDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
   Tastenbelegung : TastenbelegungArray;

   procedure WartenEingabe;
   procedure StandardTastenbelegungLaden;



   function GanzeZahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
      return Integer
     with
       Post =>
         (GanzeZahl'Result in -1_000_000_000 .. 999_999_999);

   function StadtName
     return Unbounded_Wide_Wide_String;

   function SpielstandName
     return Unbounded_Wide_Wide_String;

   function TastenEingabe
     return Sf.Window.Keyboard.sfKeyCode;

   function Tastenwert
     return SystemDatentypen.Tastenbelegung_Enum;

private

   VorherNurNullstellen : Boolean;
   WelchesVorzeichen : Boolean;

   Zahlen : Sf.Window.Keyboard.sfKeyCode;
   Taste : Sf.Window.Keyboard.sfKeyCode;

   ZeichenEingeben : Sf.Window.Event.sfEvent;

   IstZahl : KartenDatentypen.LoopRangeMinusDreiZuDrei;

   ZahlenMaximum : constant Positive := 999_999_999;
   ZahlenMinimum : constant Integer := -999_999_999;

   MaximumMinimumAktuelleStelle : Positive;
   ZahlenMinimumPlusmacher : Positive;

   MaximalerWert : Integer;
   MinimalerWert : Integer;
   Wert : Integer;

   ZahlenString : Wide_Wide_String (1 .. 9);

   Name : Unbounded_Wide_Wide_String;
   MaximumMinimum : Unbounded_Wide_Wide_String;

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
                                                                Hoch                           => Sf.Window.Keyboard.sfKeyW,
                                                                Links                          => Sf.Window.Keyboard.sfKeyA,
                                                                Runter                         => Sf.Window.Keyboard.sfKeyS,
                                                                Rechts                         => Sf.Window.Keyboard.sfKeyD,
                                                                Links_Oben                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Rechts_Oben                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Links_Unten                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Rechts_Unten                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Ebene_Hoch                     => Sf.Window.Keyboard.sfKeyAdd,
                                                                Ebene_Runter                   => Sf.Window.Keyboard.sfKeySubtract,

                                                                Auswählen                      => Sf.Window.Keyboard.sfKeyE,
                                                                Menü_Zurück                    => Sf.Window.Keyboard.sfKeyQ,
                                                                Bauen                          => Sf.Window.Keyboard.sfKeyB,
                                                                Forschung                      => Sf.Window.Keyboard.sfKeyT,
                                                                Tech_Baum                      => Sf.Window.Keyboard.sfKeyX,

                                                                Nächste_Stadt                  => Sf.Window.Keyboard.sfKeySlash,
                                                                Einheit_Mit_Bewegungspunkte    => Sf.Window.Keyboard.sfKeyPeriod,
                                                                Alle_Einheiten                 => Sf.Window.Keyboard.sfKeyMultiply,
                                                                Einheiten_Ohne_Bewegungspunkte => Sf.Window.Keyboard.sfKeyComma,
                                                                Nächste_Stadt_Mit_Meldung      => Sf.Window.Keyboard.sfKeyNum0,
                                                                Nächste_Einheit_Mit_Meldung    => Sf.Window.Keyboard.sfKeyO,

                                                                Straße_Bauen                   => Sf.Window.Keyboard.sfKeyL,
                                                                Mine_Bauen                     => Sf.Window.Keyboard.sfKeyM,
                                                                Farm_Bauen                     => Sf.Window.Keyboard.sfKeyF,
                                                                Festung_Bauen                  => Sf.Window.Keyboard.sfKeyU,
                                                                Wald_Aufforsten                => Sf.Window.Keyboard.sfKeyZ,
                                                                Roden_Trockenlegen             => Sf.Window.Keyboard.sfKeyP,
                                                                Heilen                         => Sf.Window.Keyboard.sfKeyH,
                                                                Verschanzen                    => Sf.Window.Keyboard.sfKeyV,
                                                                Runde_Aussetzen                => Sf.Window.Keyboard.sfKeySpace,
                                                                Einheit_Auflösen               => Sf.Window.Keyboard.sfKeyDelete,
                                                                Plündern                       => Sf.Window.Keyboard.sfKeyJ,
                                                                Heimatstadt_Ändern             => Sf.Window.Keyboard.sfKeyNum5,
                                                                Einheit_Verbessern             => Sf.Window.Keyboard.sfKeyTab,
                                                                Infos                          => Sf.Window.Keyboard.sfKeyI,

                                                                Diplomatie                     => Sf.Window.Keyboard.sfKeyTilde,

                                                                GeheZu                         => Sf.Window.Keyboard.sfKeyG,

                                                                Stadt_Umbenennen               => Sf.Window.Keyboard.sfKeyN,
                                                                Stadt_Abreißen                 => Sf.Window.Keyboard.sfKeyK,
                                                                Stadt_Suchen                   => Sf.Window.Keyboard.sfKeyY,

                                                                Runde_Beenden                  => Sf.Window.Keyboard.sfKeyR,
                                                                Cheatmenü                      => Sf.Window.Keyboard.sfKeyC
                                                               ),

                                                             2 =>
                                                               (
                                                                Hoch                           => Sf.Window.Keyboard.sfKeyNum8,
                                                                Links                          => Sf.Window.Keyboard.sfKeyNum4,
                                                                Runter                         => Sf.Window.Keyboard.sfKeyNum2,
                                                                Rechts                         => Sf.Window.Keyboard.sfKeyNum6,
                                                                Links_Oben                     => Sf.Window.Keyboard.sfKeyNum7,
                                                                Rechts_Oben                    => Sf.Window.Keyboard.sfKeyNum9,
                                                                Links_Unten                    => Sf.Window.Keyboard.sfKeyNum1,
                                                                Rechts_Unten                   => Sf.Window.Keyboard.sfKeyNum3,
                                                                Ebene_Hoch                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Ebene_Runter                   => Sf.Window.Keyboard.sfKeyUnknown,

                                                                Auswählen                      => Sf.Window.Keyboard.sfKeyEnter,
                                                                Menü_Zurück                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Bauen                          => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Forschung                      => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Tech_Baum                      => Sf.Window.Keyboard.sfKeyUnknown,

                                                                Nächste_Stadt                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Einheit_Mit_Bewegungspunkte    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Alle_Einheiten                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Einheiten_Ohne_Bewegungspunkte => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Nächste_Stadt_Mit_Meldung      => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Nächste_Einheit_Mit_Meldung    => Sf.Window.Keyboard.sfKeyUnknown,

                                                                Straße_Bauen                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Mine_Bauen                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Farm_Bauen                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Festung_Bauen                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Wald_Aufforsten                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Roden_Trockenlegen             => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Heilen                         => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Verschanzen                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Runde_Aussetzen                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Einheit_Auflösen               => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Plündern                       => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Heimatstadt_Ändern             => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Einheit_Verbessern             => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Infos                          => Sf.Window.Keyboard.sfKeyUnknown,

                                                                Diplomatie                     => Sf.Window.Keyboard.sfKeyUnknown,

                                                                GeheZu                         => Sf.Window.Keyboard.sfKeyUnknown,

                                                                Stadt_Umbenennen               => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Stadt_Abreißen                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Stadt_Suchen                   => Sf.Window.Keyboard.sfKeyUnknown,

                                                                Runde_Beenden                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                Cheatmenü                      => Sf.Window.Keyboard.sfKeyUnknown
                                                               )
                                                            );

   procedure ZahlenAnzeige
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer);

   procedure MinimumMaximumSetzen
     (ZahlenMinimumMaximumExtern : in Integer)
     with
       Pre =>
         (ZahlenMinimumMaximumExtern in -99_999_999 .. 99_999_999);

   procedure ZahlHinzufügen
     (ZahlenMaximumExtern : in Integer;
      EingegebeneZahlExtern : in Sf.Window.Keyboard.sfKeyCode);

   procedure ZahlEntfernen;



   function GanzeZahlPrüfung
     (ZeichenExtern : in Sf.Window.Keyboard.sfKeyCode)
      return KartenDatentypen.LoopRangeMinusDreiZuDrei;

   function ZahlSchleife
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
      return KartenDatentypen.LoopRangeMinusZweiZuZwei
     with
       Pre =>
         (ZahlenMaximumExtern <= 999_999_999
          and
            ZahlenMinimumExtern < ZahlenMaximumExtern
          and
            ZahlenMinimumExtern >= -999_999_999);

   function MaximumErmitteln
     (ZahlenMaximumExtern : in Integer)
      return Integer;

   function MinimumErmitteln
     (ZahlenMinimumExtern : in Integer)
      return Integer;

   function NameEingeben
     return Unbounded_Wide_Wide_String;

end Eingabe;
