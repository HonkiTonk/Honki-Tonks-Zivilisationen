pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleDatentypen;
use GlobaleDatentypen;

package Eingabe is

   type TastenbelegungArray is array (1 .. 2, 1 .. 100) of Wide_Wide_Character;
   Tastenbelegung : TastenbelegungArray := (1 => (1 => 'w', -- Cursor/Einheitenbewegung
                                                  2 => 'a',
                                                  3 => 's',
                                                  4 => 'd',
                                                  5 => NUL,
                                                  6 => NUL,
                                                  7 => NUL,
                                                  8 => NUL,
                                                  9 => '+',
                                                  10 => '-', -- Cursor/Einheitenbewegung

                                                  11 => 'e', -- Auswählen
                                                  12 => 'q', -- Menü aufrufen und Dinge verlassen

                                                  13 => 'b', -- Zeug bauen

                                                  14 => 't', -- Forschung
                                                  15 => 'x', -- Forschungsbaum

                                                  16 => '/', -- Nächste Stadt
                                                  17 => '.', -- Einheiten mit Bewegungspunkten
                                                  18 => '*', -- Alle Einheiten
                                                  19 => ',', -- Einheiten ohne Bewegungspunkte

                                                  20 => 'l', -- Straße bauen
                                                  21 => 'm', -- Mine bauen
                                                  22 => 'f', -- Farm bauen
                                                  23 => 'u', -- Festung bauen
                                                  24 => 'z', -- Wald aufforsten
                                                  25 => 'p', -- Roden-Trockenlegen
                                                  26 => 'h', -- Heilen
                                                  27 => 'v', -- Verschanzen
                                                  28 => Space, -- Runde aussetzen
                                                  29 => DEL, -- Einheit auflösen
                                                  30 => 'j', -- Plündern

                                                  31 => 'i', -- Informationen für Einheiten, Verbesserungen, usw.

                                                  32 => '#', -- Diplomatie

                                                  33 => 'g', -- GeheZu Cursor

                                                  34 => 'n', -- Stadt umbenennen
                                                  35 => 'k', -- Stadt abreißen
                                                  36 => 'y', -- Stadt mit Namen suchen

                                                  37 => 'r', -- Runde beenden
                                                  38 => 'c', -- Cheatmenü aufrufen

                                                  others => NUL),

                                            2 => (1 => '8', -- Cursor/Einheitenbewegung
                                                  2 => '4',
                                                  3 => '2',
                                                  4 => '6',
                                                  5 => '7',
                                                  6 => '9',
                                                  7 => '1',
                                                  8 => '3',
                                                  9 => NUL,
                                                  10 => NUL, -- Cursor/Einheitenbewegung

                                                  11 => '5', -- Auswählen
                                                  12 => NUL, -- Menü aufrufen und Dinge verlassen

                                                  13 => NUL, -- Stadt bauen

                                                  14 => NUL, -- Forschung
                                                  15 => NUL, -- Forschungsbaum

                                                  16 => NUL, -- Nächste Stadt
                                                  17 => NUL, -- Einheiten mit Bewegungspunkten
                                                  18 => NUL, -- Alle Einheiten
                                                  19 => NUL, -- Einheiten ohne Bewegungspunkte

                                                  20 => NUL, -- Straße bauen
                                                  21 => NUL, -- Mine bauen
                                                  22 => NUL, -- Farm bauen
                                                  23 => NUL, -- Festung bauen
                                                  24 => NUL, -- Wald aufforsten
                                                  25 => NUL, -- Roden-Trockenlegen
                                                  26 => NUL, -- Heilen
                                                  27 => NUL, -- Verschanzen
                                                  28 => NUL, -- Runde aussetzen
                                                  29 => NUL, -- Einheit auflösen
                                                  30 => NUL, -- Plündern

                                                  31 => NUL, -- Informationen für Einheiten, Verbesserungen, usw.

                                                  32 => NUL, -- Diplomatie

                                                  33 => NUL, -- GeheZu Cursor

                                                  34 => NUL, -- Stadt umbenennen
                                                  35 => NUL, -- Stadt abreißen
                                                  36 => NUL, -- Stadt mit Namen suchen

                                                  37 => NUL, -- Runde beenden
                                                  38 => NUL, -- Cheatmenü aufrufen

                                                  others => NUL));

   procedure WartenEingabe;

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

   SchleifeVerlassen : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
   IstZahl : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   Wert : Integer;

   ZahlenString : Wide_Wide_String (1 .. 9);

   Name : Unbounded_Wide_Wide_String;

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

end Eingabe;
