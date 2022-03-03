pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with SystemDatentypen;
with KartenDatentypen;
with SystemRecords;
with SystemKonstanten;

package EingabeKonsole is

   WelchesVorzeichen : Boolean;

   Frage : Positive;

   AktuellerWert : Natural;

   type TastenbelegungArray is array (1 .. 2, SystemDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Wide_Wide_Character;
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
     return SystemDatentypen.Tastenbelegung_Enum;

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
                                                                SystemKonstanten.ObenKonstante                         => 'w',
                                                                SystemKonstanten.LinksKonstante                        => 'a',
                                                                SystemKonstanten.UntenKonstante                        => 's',
                                                                SystemKonstanten.RechtsKonstante                       => 'd',
                                                                SystemKonstanten.LinksObenKonstante                    => NUL,
                                                                SystemKonstanten.RechtsObenKonstante                   => NUL,
                                                                SystemKonstanten.LinksUntenKonstante                   => NUL,
                                                                SystemKonstanten.RechtsUntenKonstante                  => NUL,
                                                                SystemKonstanten.EbeneHochKonstante                    => '+',
                                                                SystemKonstanten.EbeneRunterKonstante                  => '-',

                                                                SystemKonstanten.AuswählenKonstante                    => 'e',
                                                                SystemKonstanten.MenüZurückKonstante                   => 'q',
                                                                SystemKonstanten.BauenKonstante                        => 'b',
                                                                SystemKonstanten.ForschungKonstante                    => 't',
                                                                SystemKonstanten.TechBaumKonstante                     => 'x',

                                                                SystemKonstanten.NächsteStadtKonstante                 => '/',
                                                                SystemKonstanten.EinheitMitBewegungspunkteKonstante    => '.',
                                                                SystemKonstanten.AlleEinheitenKonstante                => '*',
                                                                SystemKonstanten.EinheitenOhneBewegungspunkteKonstante => ',',
                                                                SystemKonstanten.NächsteStadtMeldungKonstante          => '0',
                                                                SystemKonstanten.NächsteEinheitMeldungKonstante        => 'o',

                                                                SystemKonstanten.StraßeBauenKonstante                  => 'l',
                                                                SystemKonstanten.MineBauenKonstante                    => 'm',
                                                                SystemKonstanten.FarmBauenKonstante                    => 'f',
                                                                SystemKonstanten.FestungBauenKonstante                 => 'u',
                                                                SystemKonstanten.WaldAufforstenKonstante               => 'z',
                                                                SystemKonstanten.RodenTrockenlegenKonstante            => 'p',
                                                                SystemKonstanten.HeilenKonstante                       => 'h',
                                                                SystemKonstanten.VerschanzenKonstante                  => 'v',
                                                                SystemKonstanten.RundeAussetzenKonstante               => Space,
                                                                SystemKonstanten.AuflösenKonstante                     => DEL,
                                                                SystemKonstanten.PlündernKonstante                     => 'j',
                                                                SystemKonstanten.HeimatstadtÄndernKonstante            => '<',
                                                                SystemKonstanten.EinheitVerbessernKonstante            => HT,
                                                                SystemKonstanten.InfosKonstante                        => 'i',

                                                                SystemKonstanten.DiplomatieKonstante                   => '#',

                                                                SystemKonstanten.GeheZuKonstante                       => 'g',

                                                                SystemKonstanten.StadtUmbenennenKonstante              => 'n',
                                                                SystemKonstanten.StadtAbreißenKonstante                => 'k',
                                                                SystemKonstanten.StadtSuchenKonstante                  => 'y',

                                                                SystemKonstanten.RundeBeendenTastenbelegungKonstante   => 'r',
                                                                SystemKonstanten.DebugmenüKonstante                    => 'c'),

                                                             2 =>
                                                               (
                                                                SystemKonstanten.ObenKonstante                         => '8',
                                                                SystemKonstanten.LinksKonstante                        => '4',
                                                                SystemKonstanten.UntenKonstante                        => '2',
                                                                SystemKonstanten.RechtsKonstante                       => '6',
                                                                SystemKonstanten.LinksObenKonstante                    => '7',
                                                                SystemKonstanten.RechtsObenKonstante                   => '9',
                                                                SystemKonstanten.LinksUntenKonstante                   => '1',
                                                                SystemKonstanten.RechtsUntenKonstante                  => '3',
                                                                SystemKonstanten.EbeneHochKonstante                    => NUL,
                                                                SystemKonstanten.EbeneRunterKonstante                  => NUL,

                                                                SystemKonstanten.AuswählenKonstante                    => LF,
                                                                SystemKonstanten.MenüZurückKonstante                   => NUL,
                                                                SystemKonstanten.BauenKonstante                        => NUL,
                                                                SystemKonstanten.ForschungKonstante                    => NUL,
                                                                SystemKonstanten.TechBaumKonstante                     => NUL,

                                                                SystemKonstanten.NächsteStadtKonstante                 => NUL,
                                                                SystemKonstanten.EinheitMitBewegungspunkteKonstante    => NUL,
                                                                SystemKonstanten.AlleEinheitenKonstante                => NUL,
                                                                SystemKonstanten.EinheitenOhneBewegungspunkteKonstante => NUL,
                                                                SystemKonstanten.NächsteStadtMeldungKonstante          => NUL,
                                                                SystemKonstanten.NächsteEinheitMeldungKonstante        => NUL,

                                                                SystemKonstanten.StraßeBauenKonstante                  => NUL,
                                                                SystemKonstanten.MineBauenKonstante                    => NUL,
                                                                SystemKonstanten.FarmBauenKonstante                    => NUL,
                                                                SystemKonstanten.FestungBauenKonstante                 => NUL,
                                                                SystemKonstanten.WaldAufforstenKonstante               => NUL,
                                                                SystemKonstanten.RodenTrockenlegenKonstante            => NUL,
                                                                SystemKonstanten.HeilenKonstante                       => NUL,
                                                                SystemKonstanten.VerschanzenKonstante                  => NUL,
                                                                SystemKonstanten.RundeAussetzenKonstante               => NUL,
                                                                SystemKonstanten.AuflösenKonstante                     => NUL,
                                                                SystemKonstanten.PlündernKonstante                     => NUL,
                                                                SystemKonstanten.HeimatstadtÄndernKonstante            => NUL,
                                                                SystemKonstanten.EinheitVerbessernKonstante            => NUL,
                                                                SystemKonstanten.InfosKonstante                        => NUL,

                                                                SystemKonstanten.DiplomatieKonstante                   => NUL,

                                                                SystemKonstanten.GeheZuKonstante                       => NUL,

                                                                SystemKonstanten.StadtUmbenennenKonstante              => NUL,
                                                                SystemKonstanten.StadtAbreißenKonstante                => NUL,
                                                                SystemKonstanten.StadtSuchenKonstante                  => NUL,

                                                                SystemKonstanten.RundeBeendenTastenbelegungKonstante   => NUL,
                                                                SystemKonstanten.DebugmenüKonstante                    => NUL)
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
