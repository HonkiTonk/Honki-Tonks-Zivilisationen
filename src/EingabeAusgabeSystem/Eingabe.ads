pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Eingabe is

   type TastenbelegungArray is array (1 .. 2, 1 .. 38) of Wide_Wide_Character;

   -- Auf Enum umschreiben?
   Tastenbelegung : TastenbelegungArray := (
                                            1 =>
                                              (
                                               -- Cursor/Einheitenbewegung
                                               1 => 'w',
                                               2 => 'a',
                                               3 => 's',
                                               4 => 'd',
                                               5 => NUL,
                                               6 => NUL,
                                               7 => NUL,
                                               8 => NUL,
                                               9 => '+',
                                               10 => '-',

                                               -- Auswählen
                                               11 => 'e',
                                               -- Menü aufrufen und Dinge verlassen
                                               12 => 'q',
                                               -- Zeug bauen
                                               13 => 'b',
                                               -- Forschung
                                               14 => 't',
                                               -- Forschungsbaum
                                               15 => 'x',

                                               -- Nächste Stadt
                                               16 => '/',
                                               -- Einheiten mit Bewegungspunkten
                                               17 => '.',
                                               -- Alle Einheiten
                                               18 => '*',
                                               -- Einheiten ohne Bewegungspunkte
                                               19 => ',',

                                               -- Straße bauen
                                               20 => 'l',
                                               -- Mine bauen
                                               21 => 'm',
                                               -- Farm bauen
                                               22 => 'f',
                                               -- Festung bauen
                                               23 => 'u',
                                               -- Wald aufforsten
                                               24 => 'z',
                                               -- Roden-Trockenlegen
                                               25 => 'p',
                                               -- Heilen
                                               26 => 'h',
                                               -- Verschanzen
                                               27 => 'v',
                                               -- Runde aussetzen
                                               28 => Space,
                                               -- Einheit auflösen
                                               29 => DEL,
                                               -- Plündern
                                               30 => 'j',
                                               -- Informationen für Einheiten, Verbesserungen, usw.
                                               31 => 'i',

                                               -- Diplomatie
                                               32 => '#',

                                               -- GeheZu Cursor
                                               33 => 'g',

                                               -- Stadt umbenennen
                                               34 => 'n',
                                               -- Stadt abreißen
                                               35 => 'k',
                                               -- Stadt mit Namen suchen
                                               36 => 'y',

                                               -- Runde beenden
                                               37 => 'r',
                                               -- Cheatmenü aufrufen
                                               38 => 'c'),

                                            2 =>
                                              (
                                                -- Cursor/Einheitenbewegung
                                               1 => '8',
                                               2 => '4',
                                               3 => '2',
                                               4 => '6',
                                               5 => '7',
                                               6 => '9',
                                               7 => '1',
                                               8 => '3',
                                               9 => NUL,
                                               10 => NUL,

                                                -- Auswählen
                                               11 => LF,
                                               -- Menü aufrufen und Dinge verlassen
                                               12 => NUL,
                                               -- Zeug bauen
                                               13 => NUL,
                                               -- Forschung
                                               14 => NUL,
                                               -- Forschungsbaum
                                               15 => NUL,

                                               -- Nächste Stadt
                                               16 => NUL,
                                               -- Einheiten mit Bewegungspunkten
                                               17 => NUL,
                                               -- Alle Einheiten
                                               18 => NUL,
                                               -- Einheiten ohne Bewegungspunkte
                                               19 => NUL,

                                               -- Straße bauen
                                               20 => NUL,
                                               -- Mine bauen
                                               21 => NUL,
                                               -- Farm bauen
                                               22 => NUL,
                                               -- Festung bauen
                                               23 => NUL,
                                               -- Wald aufforsten
                                               24 => NUL,
                                               -- Roden-Trockenlegen
                                               25 => NUL,
                                               -- Heilen
                                               26 => NUL,
                                               -- Verschanzen
                                               27 => NUL,
                                               -- Runde aussetzen
                                               28 => NUL,
                                               -- Einheit auflösen
                                               29 => NUL,
                                               -- Plündern
                                               30 => NUL,
                                               -- Informationen für Einheiten, Verbesserungen, usw.
                                               31 => NUL,

                                               -- Diplomatie
                                               32 => NUL,

                                               -- GeheZu Cursor
                                               33 => NUL,

                                               -- Stadt umbenennen
                                               34 => NUL,
                                               -- Stadt abreißen
                                               35 => NUL,
                                               -- Stadt mit Namen suchen
                                               36 => NUL,

                                               -- Runde beenden
                                               37 => NUL,
                                               -- Cheatmenü aufrufen
                                               38 => NUL)
                                           );

   procedure WartenEingabe;

   procedure StandardTastenbelegungWiederherstellen;

   function GanzeZahl
     (TextDateiExtern : in GlobaleDatentypen.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern, ZahlenMaximumExtern : in Integer)
      return Integer
     with
       Pre  =>
         (ZahlenMaximumExtern <= 999_999_999
          and
            ZahlenMinimumExtern < ZahlenMaximumExtern
          and
            ZahlenMinimumExtern >= -999_999_999),
         Post =>
           (GanzeZahl'Result in -1_000_000_000 .. 999_999_999);

   function StadtName
     return Unbounded_Wide_Wide_String;

   function SpielstandName
     return Unbounded_Wide_Wide_String;

   function TastenEingabe
     return Wide_Wide_Character;

   function Tastenwert
     return Natural;

private

   VorherNurNullstellen : Boolean;
   WelchesVorzeichen : Boolean;

   Zahlen : Wide_Wide_Character;
   Taste : Wide_Wide_Character;

   IstZahl : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   MaximumMinimumAktuelleStelle : Positive;
   ZahlenMinimumPlusmacher : Positive;
   Wert : Integer;

   ZahlenString : Wide_Wide_String (1 .. 9);

   Name : Unbounded_Wide_Wide_String;
   MaximumMinimum : Unbounded_Wide_Wide_String;

   TastenbelegungStandard : constant TastenbelegungArray := (
                                                             1 =>
                                                               (
                                                                -- Cursor/Einheitenbewegung
                                                                1 => 'w',
                                                                2 => 'a',
                                                                3 => 's',
                                                                4 => 'd',
                                                                5 => NUL,
                                                                6 => NUL,
                                                                7 => NUL,
                                                                8 => NUL,
                                                                9 => '+',
                                                                10 => '-',

                                                                -- Auswählen
                                                                11 => 'e',
                                                                -- Menü aufrufen und Dinge verlassen
                                                                12 => 'q',
                                                                -- Zeug bauen
                                                                13 => 'b',
                                                                -- Forschung
                                                                14 => 't',
                                                                -- Forschungsbaum
                                                                15 => 'x',

                                                                -- Nächste Stadt
                                                                16 => '/',
                                                                -- Einheiten mit Bewegungspunkten
                                                                17 => '.',
                                                                -- Alle Einheiten
                                                                18 => '*',
                                                                -- Einheiten ohne Bewegungspunkte
                                                                19 => ',',

                                                                -- Straße bauen
                                                                20 => 'l',
                                                                -- Mine bauen
                                                                21 => 'm',
                                                                -- Farm bauen
                                                                22 => 'f',
                                                                -- Festung bauen
                                                                23 => 'u',
                                                                -- Wald aufforsten
                                                                24 => 'z',
                                                                -- Roden-Trockenlegen
                                                                25 => 'p',
                                                                -- Heilen
                                                                26 => 'h',
                                                                -- Verschanzen
                                                                27 => 'v',
                                                                -- Runde aussetzen
                                                                28 => Space,
                                                                -- Einheit auflösen
                                                                29 => DEL,
                                                                -- Plündern
                                                                30 => 'j',
                                                                -- Informationen für Einheiten, Verbesserungen, usw.
                                                                31 => 'i',

                                                                -- Diplomatie
                                                                32 => '#',

                                                                -- GeheZu Cursor
                                                                33 => 'g',

                                                                -- Stadt umbenennen
                                                                34 => 'n',
                                                                -- Stadt abreißen
                                                                35 => 'k',
                                                                -- Stadt mit Namen suchen
                                                                36 => 'y',

                                                                -- Runde beenden
                                                                37 => 'r',
                                                                -- Cheatmenü aufrufen
                                                                38 => 'c'),

                                                             2 =>
                                                               (
                                                                -- Cursor/Einheitenbewegung
                                                                1 => '8',
                                                                2 => '4',
                                                                3 => '2',
                                                                4 => '6',
                                                                5 => '7',
                                                                6 => '9',
                                                                7 => '1',
                                                                8 => '3',
                                                                9 => NUL,
                                                                10 => NUL,

                                                                -- Auswählen
                                                                11 => LF,
                                                                -- Menü aufrufen und Dinge verlassen
                                                                12 => NUL,
                                                                -- Zeug bauen
                                                                13 => NUL,
                                                                -- Forschung
                                                                14 => NUL,
                                                                -- Forschungsbaum
                                                                15 => NUL,

                                                                -- Nächste Stadt
                                                                16 => NUL,
                                                                -- Einheiten mit Bewegungspunkten
                                                                17 => NUL,
                                                                -- Alle Einheiten
                                                                18 => NUL,
                                                                -- Einheiten ohne Bewegungspunkte
                                                                19 => NUL,

                                                                -- Straße bauen
                                                                20 => NUL,
                                                                -- Mine bauen
                                                                21 => NUL,
                                                                -- Farm bauen
                                                                22 => NUL,
                                                                -- Festung bauen
                                                                23 => NUL,
                                                                -- Wald aufforsten
                                                                24 => NUL,
                                                                -- Roden-Trockenlegen
                                                                25 => NUL,
                                                                -- Heilen
                                                                26 => NUL,
                                                                -- Verschanzen
                                                                27 => NUL,
                                                                -- Runde aussetzen
                                                                28 => NUL,
                                                                -- Einheit auflösen
                                                                29 => NUL,
                                                                -- Plündern
                                                                30 => NUL,
                                                                -- Informationen für Einheiten, Verbesserungen, usw.
                                                                31 => NUL,

                                                                -- Diplomatie
                                                                32 => NUL,

                                                                -- GeheZu Cursor
                                                                33 => NUL,

                                                                -- Stadt umbenennen
                                                                34 => NUL,
                                                                -- Stadt abreißen
                                                                35 => NUL,
                                                                -- Stadt mit Namen suchen
                                                                36 => NUL,

                                                                -- Runde beenden
                                                                37 => NUL,
                                                                -- Cheatmenü aufrufen
                                                                38 => NUL)
                                                            );

   function GanzeZahlPrüfung
     (ZeichenExtern : in Wide_Wide_Character)
      return GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   function ZahlSchleife
     (TextDateiExtern : in GlobaleDatentypen.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern, ZahlenMaximumExtern : in Integer)
      return GlobaleDatentypen.LoopRangeMinusZweiZuZwei
     with
       Pre =>
         (ZahlenMaximumExtern <= 999_999_999
          and
            ZahlenMinimumExtern < ZahlenMaximumExtern
          and
            ZahlenMinimumExtern >= -999_999_999);

   procedure MinimumMaximumSetzen
     (ZahlenMinimumMaximumExtern : in Integer)
     with
       Pre =>
         (ZahlenMinimumMaximumExtern in -99_999_999 .. 99_999_999);

end Eingabe;
