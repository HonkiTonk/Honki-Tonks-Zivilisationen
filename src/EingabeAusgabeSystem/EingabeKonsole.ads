pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with SystemDatentypen;
with KartenDatentypen;
with GlobaleTexte;

package EingabeKonsole is

   type TastenbelegungArray is array (1 .. 2, SystemDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Wide_Wide_Character;
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
     return SystemDatentypen.Tastenbelegung_Enum;

private

   VorherNurNullstellen : Boolean;
   WelchesVorzeichen : Boolean;

   Zahlen : Wide_Wide_Character;
   Taste : Wide_Wide_Character;

   IstZahl : KartenDatentypen.LoopRangeMinusDreiZuDrei;

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
                                                                SystemDatentypen.Oben                           => 'w',
                                                                SystemDatentypen.Links                          => 'a',
                                                                SystemDatentypen.Unten                         => 's',
                                                                SystemDatentypen.Rechts                         => 'd',
                                                                SystemDatentypen.Links_Oben                     => NUL,
                                                                SystemDatentypen.Rechts_Oben                    => NUL,
                                                                SystemDatentypen.Links_Unten                    => NUL,
                                                                SystemDatentypen.Rechts_Unten                   => NUL,
                                                                SystemDatentypen.Ebene_Hoch                     => '+',
                                                                SystemDatentypen.Ebene_Runter                   => '-',

                                                                SystemDatentypen.Auswählen                      => 'e',
                                                                SystemDatentypen.Menü_Zurück                    => 'q',
                                                                SystemDatentypen.Bauen                          => 'b',
                                                                SystemDatentypen.Forschung                      => 't',
                                                                SystemDatentypen.Tech_Baum                      => 'x',

                                                                SystemDatentypen.Nächste_Stadt                  => '/',
                                                                SystemDatentypen.Einheit_Mit_Bewegungspunkte    => '.',
                                                                SystemDatentypen.Alle_Einheiten                 => '*',
                                                                SystemDatentypen.Einheiten_Ohne_Bewegungspunkte => ',',
                                                                SystemDatentypen.Nächste_Stadt_Mit_Meldung      => '0',
                                                                SystemDatentypen.Nächste_Einheit_Mit_Meldung    => 'o',

                                                                SystemDatentypen.Straße_Bauen                   => 'l',
                                                                SystemDatentypen.Mine_Bauen                     => 'm',
                                                                SystemDatentypen.Farm_Bauen                     => 'f',
                                                                SystemDatentypen.Festung_Bauen                  => 'u',
                                                                SystemDatentypen.Wald_Aufforsten                => 'z',
                                                                SystemDatentypen.Roden_Trockenlegen             => 'p',
                                                                SystemDatentypen.Heilen                         => 'h',
                                                                SystemDatentypen.Verschanzen                    => 'v',
                                                                SystemDatentypen.Runde_Aussetzen                => Space,
                                                                SystemDatentypen.Einheit_Auflösen               => DEL,
                                                                SystemDatentypen.Plündern                       => 'j',
                                                                SystemDatentypen.Heimatstadt_Ändern             => '<',
                                                                SystemDatentypen.Einheit_Verbessern             => HT,
                                                                SystemDatentypen.Infos                          => 'i',

                                                                SystemDatentypen.Diplomatie                     => '#',

                                                                SystemDatentypen.GeheZu                         => 'g',

                                                                SystemDatentypen.Stadt_Umbenennen               => 'n',
                                                                SystemDatentypen.Stadt_Abreißen                 => 'k',
                                                                SystemDatentypen.Stadt_Suchen                   => 'y',

                                                                SystemDatentypen.Runde_Beenden                  => 'r',
                                                                SystemDatentypen.Cheatmenü                      => 'c'),

                                                             2 =>
                                                               (
                                                                SystemDatentypen.Oben                           => '8',
                                                                SystemDatentypen.Links                          => '4',
                                                                SystemDatentypen.Unten                          => '2',
                                                                SystemDatentypen.Rechts                         => '6',
                                                                SystemDatentypen.Links_Oben                     => '7',
                                                                SystemDatentypen.Rechts_Oben                    => '9',
                                                                SystemDatentypen.Links_Unten                    => '1',
                                                                SystemDatentypen.Rechts_Unten                   => '3',
                                                                SystemDatentypen.Ebene_Hoch                     => NUL,
                                                                SystemDatentypen.Ebene_Runter                   => NUL,

                                                                SystemDatentypen.Auswählen                      => LF,
                                                                SystemDatentypen.Menü_Zurück                    => NUL,
                                                                SystemDatentypen.Bauen                          => NUL,
                                                                SystemDatentypen.Forschung                      => NUL,
                                                                SystemDatentypen.Tech_Baum                      => NUL,

                                                                SystemDatentypen.Nächste_Stadt                  => NUL,
                                                                SystemDatentypen.Einheit_Mit_Bewegungspunkte    => NUL,
                                                                SystemDatentypen.Alle_Einheiten                 => NUL,
                                                                SystemDatentypen.Einheiten_Ohne_Bewegungspunkte => NUL,
                                                                SystemDatentypen.Nächste_Stadt_Mit_Meldung      => NUL,
                                                                SystemDatentypen.Nächste_Einheit_Mit_Meldung    => NUL,

                                                                SystemDatentypen.Straße_Bauen                   => NUL,
                                                                SystemDatentypen.Mine_Bauen                     => NUL,
                                                                SystemDatentypen.Farm_Bauen                     => NUL,
                                                                SystemDatentypen.Festung_Bauen                  => NUL,
                                                                SystemDatentypen.Wald_Aufforsten                => NUL,
                                                                SystemDatentypen.Roden_Trockenlegen             => NUL,
                                                                SystemDatentypen.Heilen                         => NUL,
                                                                SystemDatentypen.Verschanzen                    => NUL,
                                                                SystemDatentypen.Runde_Aussetzen                => NUL,
                                                                SystemDatentypen.Einheit_Auflösen               => NUL,
                                                                SystemDatentypen.Plündern                       => NUL,
                                                                SystemDatentypen.Heimatstadt_Ändern             => NUL,
                                                                SystemDatentypen.Einheit_Verbessern             => NUL,
                                                                SystemDatentypen.Infos                          => NUL,

                                                                SystemDatentypen.Diplomatie                     => NUL,

                                                                SystemDatentypen.GeheZu                         => NUL,

                                                                SystemDatentypen.Stadt_Umbenennen               => NUL,
                                                                SystemDatentypen.Stadt_Abreißen                 => NUL,
                                                                SystemDatentypen.Stadt_Suchen                   => NUL,

                                                                SystemDatentypen.Runde_Beenden                  => NUL,
                                                                SystemDatentypen.Cheatmenü                      => NUL)
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

end EingabeKonsole;
