pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with SystemDatentypen;
with KartenDatentypen;
with SystemRecords;
with TastenbelegungDatentypen;

package EingabeKonsole is

   WelchesVorzeichen : Boolean;

   Frage : Positive;

   AktuellerWert : Natural;

   type TastenbelegungArray is array (1 .. 2, TastenbelegungDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Wide_Wide_Character;
   Tastenbelegung : TastenbelegungArray;

   procedure WartenEingabe;

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

   function TastenEingabe
     return Wide_Wide_Character;

   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum;

private

   Zahlen : Wide_Wide_Character;
   Taste : Wide_Wide_Character;

   IstZahl : KartenDatentypen.UmgebungsbereichDrei;
   AktuelleZahl : Positive;

   ZahlenStringLeer : constant Wide_Wide_String (1 .. 10) := "0000000000";
   ZahlenString : Wide_Wide_String (1 .. 10);

   Name : Unbounded_Wide_Wide_String;

   EingegebeneZahl : SystemRecords.ZahlenEingabeRecord;

   type Zahl_Prüfung_Enum is (Zahl_Hinzufügen, Eingabe_Abbrechen, Eingabe_Fertig, Zahl_Löschen, Vorzeichen_Minus, Vorzeichen_Plus, Leer);

   -- Eventuell später alle NUL durch ein (others => NUL) ersetzen.
   TastenbelegungStandard : constant TastenbelegungArray := (
                                                             1 =>
                                                               (
                                                                TastenbelegungDatentypen.Oben_Enum                         => 'w',
                                                                TastenbelegungDatentypen.Links_Enum                        => 'a',
                                                                TastenbelegungDatentypen.Unten_Enum                        => 's',
                                                                TastenbelegungDatentypen.Rechts_Enum                       => 'd',
                                                                TastenbelegungDatentypen.Links_Oben_Enum                    => NUL,
                                                                TastenbelegungDatentypen.Rechts_Oben_Enum                   => NUL,
                                                                TastenbelegungDatentypen.Links_Unten_Enum                   => NUL,
                                                                TastenbelegungDatentypen.Rechts_Unten_Enum                  => NUL,
                                                                TastenbelegungDatentypen.Ebene_Hoch_Enum                    => '+',
                                                                TastenbelegungDatentypen.Ebene_Runter_Enum                  => '-',

                                                                TastenbelegungDatentypen.Auswählen_Enum                    => 'e',
                                                                TastenbelegungDatentypen.Menü_Zurück_Enum                   => 'q',
                                                                TastenbelegungDatentypen.Bauen_Enum                        => 'b',
                                                                TastenbelegungDatentypen.Forschung_Enum                    => 't',
                                                                TastenbelegungDatentypen.Tech_Baum_Enum                     => 'x',

                                                                TastenbelegungDatentypen.Nächste_Stadt_Enum                 => '/',
                                                                TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum    => '.',
                                                                TastenbelegungDatentypen.Alle_Einheiten_Enum                => '*',
                                                                TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum => ',',
                                                                TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum          => '0',
                                                                TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum        => 'o',

                                                                TastenbelegungDatentypen.Straße_Bauen_Enum                  => 'l',
                                                                TastenbelegungDatentypen.Mine_Bauen_Enum                    => 'm',
                                                                TastenbelegungDatentypen.Farm_Bauen_Enum                    => 'f',
                                                                TastenbelegungDatentypen.Festung_Bauen_Enum                 => 'u',
                                                                TastenbelegungDatentypen.Wald_Aufforsten_Enum               => 'z',
                                                                TastenbelegungDatentypen.Roden_Trockenlegen_Enum            => 'p',
                                                                TastenbelegungDatentypen.Heilen_Enum                       => 'h',
                                                                TastenbelegungDatentypen.Verschanzen_Enum                  => 'v',
                                                                TastenbelegungDatentypen.Runde_Aussetzen_Enum               => Space,
                                                                TastenbelegungDatentypen.Auflösen_Enum                     => DEL,
                                                                TastenbelegungDatentypen.Plündern_Enum                     => 'j',
                                                                TastenbelegungDatentypen.Heimatstadt_Ändern_Enum            => '<',
                                                                TastenbelegungDatentypen.Einheit_Verbessern_Enum            => HT,
                                                                TastenbelegungDatentypen.Infos_Enum                        => 'i',

                                                                TastenbelegungDatentypen.Diplomatie_Enum                   => '#',

                                                                TastenbelegungDatentypen.Gehe_Zu_Enum                       => 'g',

                                                                TastenbelegungDatentypen.Stadt_Umbenennen_Enum              => 'n',
                                                                TastenbelegungDatentypen.Stadt_Abreißen_Enum                => 'k',
                                                                TastenbelegungDatentypen.Stadt_Suchen_Enum                  => 'y',

                                                                TastenbelegungDatentypen.Runde_Beenden_Enum   => 'r',
                                                                TastenbelegungDatentypen.Debugmenü_Enum                    => 'c'),

                                                             2 =>
                                                               (
                                                                TastenbelegungDatentypen.Oben_Enum                         => '8',
                                                                TastenbelegungDatentypen.Links_Enum                        => '4',
                                                                TastenbelegungDatentypen.Unten_Enum                        => '2',
                                                                TastenbelegungDatentypen.Rechts_Enum                       => '6',
                                                                TastenbelegungDatentypen.Links_Oben_Enum                    => '7',
                                                                TastenbelegungDatentypen.Rechts_Oben_Enum                   => '9',
                                                                TastenbelegungDatentypen.Links_Unten_Enum                   => '1',
                                                                TastenbelegungDatentypen.Rechts_Unten_Enum                  => '3',
                                                                TastenbelegungDatentypen.Ebene_Hoch_Enum                    => NUL,
                                                                TastenbelegungDatentypen.Ebene_Runter_Enum                  => NUL,

                                                                TastenbelegungDatentypen.Auswählen_Enum                    => LF,
                                                                TastenbelegungDatentypen.Menü_Zurück_Enum                   => NUL,
                                                                TastenbelegungDatentypen.Bauen_Enum                        => NUL,
                                                                TastenbelegungDatentypen.Forschung_Enum                    => NUL,
                                                                TastenbelegungDatentypen.Tech_Baum_Enum                     => NUL,

                                                                TastenbelegungDatentypen.Nächste_Stadt_Enum                 => NUL,
                                                                TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum    => NUL,
                                                                TastenbelegungDatentypen.Alle_Einheiten_Enum                => NUL,
                                                                TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum => NUL,
                                                                TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum          => NUL,
                                                                TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum        => NUL,

                                                                TastenbelegungDatentypen.Straße_Bauen_Enum                  => NUL,
                                                                TastenbelegungDatentypen.Mine_Bauen_Enum                    => NUL,
                                                                TastenbelegungDatentypen.Farm_Bauen_Enum                    => NUL,
                                                                TastenbelegungDatentypen.Festung_Bauen_Enum                 => NUL,
                                                                TastenbelegungDatentypen.Wald_Aufforsten_Enum               => NUL,
                                                                TastenbelegungDatentypen.Roden_Trockenlegen_Enum            => NUL,
                                                                TastenbelegungDatentypen.Heilen_Enum                       => NUL,
                                                                TastenbelegungDatentypen.Verschanzen_Enum                  => NUL,
                                                                TastenbelegungDatentypen.Runde_Aussetzen_Enum               => NUL,
                                                                TastenbelegungDatentypen.Auflösen_Enum                     => NUL,
                                                                TastenbelegungDatentypen.Plündern_Enum                     => NUL,
                                                                TastenbelegungDatentypen.Heimatstadt_Ändern_Enum            => NUL,
                                                                TastenbelegungDatentypen.Einheit_Verbessern_Enum            => NUL,
                                                                TastenbelegungDatentypen.Infos_Enum                        => NUL,

                                                                TastenbelegungDatentypen.Diplomatie_Enum                   => NUL,

                                                                TastenbelegungDatentypen.Gehe_Zu_Enum                       => NUL,

                                                                TastenbelegungDatentypen.Stadt_Umbenennen_Enum              => NUL,
                                                                TastenbelegungDatentypen.Stadt_Abreißen_Enum                => NUL,
                                                                TastenbelegungDatentypen.Stadt_Suchen_Enum                  => NUL,

                                                                TastenbelegungDatentypen.Runde_Beenden_Enum   => NUL,
                                                                TastenbelegungDatentypen.Debugmenü_Enum                    => NUL)
                                                            );

   procedure VorzeichenAnpassen
     (ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen;
      PlusMinusExtern : in Boolean);

   procedure ZahlHinzufügen
     (EingegebeneZahlExtern : in Wide_Wide_Character);

   procedure ZahlEntfernen;



   function MinimumMaximumSetzen
     (ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen)
      return Boolean;

   function GanzeZahlPrüfung
     (ZeichenExtern : in Wide_Wide_Character)
      return Zahl_Prüfung_Enum;

   function ZahlSchleife
     (ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen)
      return Boolean;

end EingabeKonsole;
