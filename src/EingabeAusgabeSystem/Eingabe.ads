pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleDatentypen, GlobaleTexte;
use GlobaleDatentypen;

package Eingabe is

   type TastenbelegungArray is array (1 .. 2, GlobaleDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Wide_Wide_Character;
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
     return Wide_Wide_Character;

   function Tastenwert
     return GlobaleDatentypen.Tastenbelegung_Enum;

private

   VorherNurNullstellen : Boolean;
   WelchesVorzeichen : Boolean;

   Zahlen : Wide_Wide_Character;
   Taste : Wide_Wide_Character;

   IstZahl : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   MaximumMinimumAktuelleStelle : Positive;
   ZahlenMinimumPlusmacher : Positive;
   ZahlenMaximum : constant Positive := 999_999_999;
   ZahlenMinimum : constant Integer := -999_999_999;
   MaximalerWert : Integer;
   MinimalerWert : Integer;

   Wert : Integer;

   ZahlenString : Wide_Wide_String (1 .. 9);

   Name : Unbounded_Wide_Wide_String;
   MaximumMinimum : Unbounded_Wide_Wide_String;

   TastenbelegungStandard : constant TastenbelegungArray := (
                                                             1 =>
                                                               (
                                                                Hoch                           => 'w',
                                                                Links                          => 'a',
                                                                Runter                         => 's',
                                                                Rechts                         => 'd',
                                                                Links_Oben                     => NUL,
                                                                Rechts_Oben                    => NUL,
                                                                Links_Unten                    => NUL,
                                                                Rechts_Unten                   => NUL,
                                                                Ebene_Hoch                     => '+',
                                                                Ebene_Runter                   => '-',

                                                                Auswählen                      => 'e',
                                                                Menü_Zurück                    => 'q',
                                                                Bauen                          => 'b',
                                                                Forschung                      => 't',
                                                                Tech_Baum                      => 'x',

                                                                Nächste_Stadt                  => '/',
                                                                Einheit_Mit_Bewegungspunkte    => '.',
                                                                Alle_Einheiten                 => '*',
                                                                Einheiten_Ohne_Bewegungspunkte => ',',
                                                                Nächste_Stadt_Mit_Meldung      => '0',
                                                                Nächste_Einheit_Mit_Meldung    => 'o',

                                                                Straße_Bauen                   => 'l',
                                                                Mine_Bauen                     => 'm',
                                                                Farm_Bauen                     => 'f',
                                                                Festung_Bauen                  => 'u',
                                                                Wald_Aufforsten                => 'z',
                                                                Roden_Trockenlegen             => 'p',
                                                                Heilen                         => 'h',
                                                                Verschanzen                    => 'v',
                                                                Runde_Aussetzen                => Space,
                                                                Einheit_Auflösen               => DEL,
                                                                Plündern                       => 'j',
                                                                Heimatstadt_Ändern             => '<',
                                                                Einheit_Verbessern             => HT,
                                                                Infos                          => 'i',

                                                                Diplomatie                     => '#',

                                                                GeheZu                         => 'g',

                                                                Stadt_Umbenennen               => 'n',
                                                                Stadt_Abreißen                 => 'k',
                                                                Stadt_Suchen                   => 'y',

                                                                Runde_Beenden                  => 'r',
                                                                Cheatmenü                      => 'c'),

                                                             2 =>
                                                               (
                                                                Hoch                           => '8',
                                                                Links                          => '4',
                                                                Runter                         => '2',
                                                                Rechts                         => '6',
                                                                Links_Oben                     => '7',
                                                                Rechts_Oben                    => '9',
                                                                Links_Unten                    => '1',
                                                                Rechts_Unten                   => '3',
                                                                Ebene_Hoch                     => NUL,
                                                                Ebene_Runter                   => NUL,

                                                                Auswählen                      => LF,
                                                                Menü_Zurück                    => NUL,
                                                                Bauen                          => NUL,
                                                                Forschung                      => NUL,
                                                                Tech_Baum                      => NUL,

                                                                Nächste_Stadt                  => NUL,
                                                                Einheit_Mit_Bewegungspunkte    => NUL,
                                                                Alle_Einheiten                 => NUL,
                                                                Einheiten_Ohne_Bewegungspunkte => NUL,
                                                                Nächste_Stadt_Mit_Meldung      => NUL,
                                                                Nächste_Einheit_Mit_Meldung    => NUL,

                                                                Straße_Bauen                   => NUL,
                                                                Mine_Bauen                     => NUL,
                                                                Farm_Bauen                     => NUL,
                                                                Festung_Bauen                  => NUL,
                                                                Wald_Aufforsten                => NUL,
                                                                Roden_Trockenlegen             => NUL,
                                                                Heilen                         => NUL,
                                                                Verschanzen                    => NUL,
                                                                Runde_Aussetzen                => NUL,
                                                                Einheit_Auflösen               => NUL,
                                                                Plündern                       => NUL,
                                                                Heimatstadt_Ändern             => NUL,
                                                                Einheit_Verbessern             => NUL,
                                                                Infos                          => NUL,

                                                                Diplomatie                     => NUL,

                                                                GeheZu                         => NUL,

                                                                Stadt_Umbenennen               => NUL,
                                                                Stadt_Abreißen                 => NUL,
                                                                Stadt_Suchen                   => NUL,

                                                                Runde_Beenden                  => NUL,
                                                                Cheatmenü                      => NUL)
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
      EingegebeneZahlExtern : in Wide_Wide_Character);

   procedure ZahlEntfernen;



   function GanzeZahlPrüfung
     (ZeichenExtern : in Wide_Wide_Character)
      return GlobaleDatentypen.LoopRangeMinusDreiZuDrei;

   function ZahlSchleife
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
      return GlobaleDatentypen.LoopRangeMinusZweiZuZwei
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

end Eingabe;
