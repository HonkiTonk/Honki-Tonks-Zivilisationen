pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with SystemDatentypen;
with KartenDatentypen;
with SystemRecords;
with TastenbelegungDatentypen;
with TastenbelegungKonstanten;

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
                                                                TastenbelegungKonstanten.ObenKonstante                         => 'w',
                                                                TastenbelegungKonstanten.LinksKonstante                        => 'a',
                                                                TastenbelegungKonstanten.UntenKonstante                        => 's',
                                                                TastenbelegungKonstanten.RechtsKonstante                       => 'd',
                                                                TastenbelegungKonstanten.LinksObenKonstante                    => NUL,
                                                                TastenbelegungKonstanten.RechtsObenKonstante                   => NUL,
                                                                TastenbelegungKonstanten.LinksUntenKonstante                   => NUL,
                                                                TastenbelegungKonstanten.RechtsUntenKonstante                  => NUL,
                                                                TastenbelegungKonstanten.EbeneHochKonstante                    => '+',
                                                                TastenbelegungKonstanten.EbeneRunterKonstante                  => '-',

                                                                TastenbelegungKonstanten.AuswählenKonstante                    => 'e',
                                                                TastenbelegungKonstanten.MenüZurückKonstante                   => 'q',
                                                                TastenbelegungKonstanten.BauenKonstante                        => 'b',
                                                                TastenbelegungKonstanten.ForschungKonstante                    => 't',
                                                                TastenbelegungKonstanten.TechBaumKonstante                     => 'x',

                                                                TastenbelegungKonstanten.NächsteStadtKonstante                 => '/',
                                                                TastenbelegungKonstanten.EinheitMitBewegungspunkteKonstante    => '.',
                                                                TastenbelegungKonstanten.AlleEinheitenKonstante                => '*',
                                                                TastenbelegungKonstanten.EinheitenOhneBewegungspunkteKonstante => ',',
                                                                TastenbelegungKonstanten.NächsteStadtMeldungKonstante          => '0',
                                                                TastenbelegungKonstanten.NächsteEinheitMeldungKonstante        => 'o',

                                                                TastenbelegungKonstanten.StraßeBauenKonstante                  => 'l',
                                                                TastenbelegungKonstanten.MineBauenKonstante                    => 'm',
                                                                TastenbelegungKonstanten.FarmBauenKonstante                    => 'f',
                                                                TastenbelegungKonstanten.FestungBauenKonstante                 => 'u',
                                                                TastenbelegungKonstanten.WaldAufforstenKonstante               => 'z',
                                                                TastenbelegungKonstanten.RodenTrockenlegenKonstante            => 'p',
                                                                TastenbelegungKonstanten.HeilenKonstante                       => 'h',
                                                                TastenbelegungKonstanten.VerschanzenKonstante                  => 'v',
                                                                TastenbelegungKonstanten.RundeAussetzenKonstante               => Space,
                                                                TastenbelegungKonstanten.AuflösenKonstante                     => DEL,
                                                                TastenbelegungKonstanten.PlündernKonstante                     => 'j',
                                                                TastenbelegungKonstanten.HeimatstadtÄndernKonstante            => '<',
                                                                TastenbelegungKonstanten.EinheitVerbessernKonstante            => HT,
                                                                TastenbelegungKonstanten.InfosKonstante                        => 'i',

                                                                TastenbelegungKonstanten.DiplomatieKonstante                   => '#',

                                                                TastenbelegungKonstanten.GeheZuKonstante                       => 'g',

                                                                TastenbelegungKonstanten.StadtUmbenennenKonstante              => 'n',
                                                                TastenbelegungKonstanten.StadtAbreißenKonstante                => 'k',
                                                                TastenbelegungKonstanten.StadtSuchenKonstante                  => 'y',

                                                                TastenbelegungKonstanten.RundeBeendenTastenbelegungKonstante   => 'r',
                                                                TastenbelegungKonstanten.DebugmenüKonstante                    => 'c'),

                                                             2 =>
                                                               (
                                                                TastenbelegungKonstanten.ObenKonstante                         => '8',
                                                                TastenbelegungKonstanten.LinksKonstante                        => '4',
                                                                TastenbelegungKonstanten.UntenKonstante                        => '2',
                                                                TastenbelegungKonstanten.RechtsKonstante                       => '6',
                                                                TastenbelegungKonstanten.LinksObenKonstante                    => '7',
                                                                TastenbelegungKonstanten.RechtsObenKonstante                   => '9',
                                                                TastenbelegungKonstanten.LinksUntenKonstante                   => '1',
                                                                TastenbelegungKonstanten.RechtsUntenKonstante                  => '3',
                                                                TastenbelegungKonstanten.EbeneHochKonstante                    => NUL,
                                                                TastenbelegungKonstanten.EbeneRunterKonstante                  => NUL,

                                                                TastenbelegungKonstanten.AuswählenKonstante                    => LF,
                                                                TastenbelegungKonstanten.MenüZurückKonstante                   => NUL,
                                                                TastenbelegungKonstanten.BauenKonstante                        => NUL,
                                                                TastenbelegungKonstanten.ForschungKonstante                    => NUL,
                                                                TastenbelegungKonstanten.TechBaumKonstante                     => NUL,

                                                                TastenbelegungKonstanten.NächsteStadtKonstante                 => NUL,
                                                                TastenbelegungKonstanten.EinheitMitBewegungspunkteKonstante    => NUL,
                                                                TastenbelegungKonstanten.AlleEinheitenKonstante                => NUL,
                                                                TastenbelegungKonstanten.EinheitenOhneBewegungspunkteKonstante => NUL,
                                                                TastenbelegungKonstanten.NächsteStadtMeldungKonstante          => NUL,
                                                                TastenbelegungKonstanten.NächsteEinheitMeldungKonstante        => NUL,

                                                                TastenbelegungKonstanten.StraßeBauenKonstante                  => NUL,
                                                                TastenbelegungKonstanten.MineBauenKonstante                    => NUL,
                                                                TastenbelegungKonstanten.FarmBauenKonstante                    => NUL,
                                                                TastenbelegungKonstanten.FestungBauenKonstante                 => NUL,
                                                                TastenbelegungKonstanten.WaldAufforstenKonstante               => NUL,
                                                                TastenbelegungKonstanten.RodenTrockenlegenKonstante            => NUL,
                                                                TastenbelegungKonstanten.HeilenKonstante                       => NUL,
                                                                TastenbelegungKonstanten.VerschanzenKonstante                  => NUL,
                                                                TastenbelegungKonstanten.RundeAussetzenKonstante               => NUL,
                                                                TastenbelegungKonstanten.AuflösenKonstante                     => NUL,
                                                                TastenbelegungKonstanten.PlündernKonstante                     => NUL,
                                                                TastenbelegungKonstanten.HeimatstadtÄndernKonstante            => NUL,
                                                                TastenbelegungKonstanten.EinheitVerbessernKonstante            => NUL,
                                                                TastenbelegungKonstanten.InfosKonstante                        => NUL,

                                                                TastenbelegungKonstanten.DiplomatieKonstante                   => NUL,

                                                                TastenbelegungKonstanten.GeheZuKonstante                       => NUL,

                                                                TastenbelegungKonstanten.StadtUmbenennenKonstante              => NUL,
                                                                TastenbelegungKonstanten.StadtAbreißenKonstante                => NUL,
                                                                TastenbelegungKonstanten.StadtSuchenKonstante                  => NUL,

                                                                TastenbelegungKonstanten.RundeBeendenTastenbelegungKonstante   => NUL,
                                                                TastenbelegungKonstanten.DebugmenüKonstante                    => NUL)
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
