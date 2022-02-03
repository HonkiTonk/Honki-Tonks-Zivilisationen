pragma SPARK_Mode (On);

with Sf.Window.Keyboard;

with SystemDatentypen;
with SystemRecords;
with SystemKonstanten;

package EingabeSFML is
   
   WelchesVorzeichen : Boolean;
   
   Frage : Positive;
   
   AktuellerWert : Natural;
      
   type TastenbelegungArray is array (1 .. 2, SystemDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
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
                                                                SystemKonstanten.ObenKonstante                         => Sf.Window.Keyboard.sfKeyW,
                                                                SystemKonstanten.LinksKonstante                        => Sf.Window.Keyboard.sfKeyA,
                                                                SystemKonstanten.UntenKonstante                        => Sf.Window.Keyboard.sfKeyS,
                                                                SystemKonstanten.RechtsKonstante                       => Sf.Window.Keyboard.sfKeyD,
                                                                SystemKonstanten.LinksObenKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.RechtsObenKonstante                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.LinksUntenKonstante                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.RechtsUntenKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.EbeneHochKonstante                    => Sf.Window.Keyboard.sfKeyAdd,
                                                                SystemKonstanten.EbeneRunterKonstante                  => Sf.Window.Keyboard.sfKeySubtract,

                                                                SystemKonstanten.AuswählenKonstante                    => Sf.Window.Keyboard.sfKeyE,
                                                                SystemKonstanten.MenüZurückKonstante                   => Sf.Window.Keyboard.sfKeyEscape,
                                                                SystemKonstanten.BauenKonstante                        => Sf.Window.Keyboard.sfKeyB,
                                                                SystemKonstanten.ForschungKonstante                    => Sf.Window.Keyboard.sfKeyT,
                                                                SystemKonstanten.TechBaumKonstante                     => Sf.Window.Keyboard.sfKeyX,

                                                                SystemKonstanten.NächsteStadtKonstante                 => Sf.Window.Keyboard.sfKeySlash,
                                                                SystemKonstanten.EinheitMitBewegungspunkteKonstante    => Sf.Window.Keyboard.sfKeyPeriod,
                                                                SystemKonstanten.AlleEinheitenKonstante                => Sf.Window.Keyboard.sfKeyMultiply,
                                                                SystemKonstanten.EinheitenOhneBewegungspunkteKonstante => Sf.Window.Keyboard.sfKeyComma,
                                                                SystemKonstanten.NächsteStadtMeldungKonstante          => Sf.Window.Keyboard.sfKeyNum0,
                                                                SystemKonstanten.NächsteEinheitMeldungKonstante        => Sf.Window.Keyboard.sfKeyO,

                                                                SystemKonstanten.StraßeBauenKonstante                  => Sf.Window.Keyboard.sfKeyL,
                                                                SystemKonstanten.MineBauenKonstante                    => Sf.Window.Keyboard.sfKeyM,
                                                                SystemKonstanten.FarmBauenKonstante                    => Sf.Window.Keyboard.sfKeyF,
                                                                SystemKonstanten.FestungBauenKonstante                 => Sf.Window.Keyboard.sfKeyU,
                                                                SystemKonstanten.WaldAufforstenKonstante               => Sf.Window.Keyboard.sfKeyZ,
                                                                SystemKonstanten.RodenTrockenlegenKonstante            => Sf.Window.Keyboard.sfKeyP,
                                                                SystemKonstanten.HeilenKonstante                       => Sf.Window.Keyboard.sfKeyH,
                                                                SystemKonstanten.VerschanzenKonstante                  => Sf.Window.Keyboard.sfKeyV,
                                                                SystemKonstanten.RundeAussetzenKonstante               => Sf.Window.Keyboard.sfKeySpace,
                                                                SystemKonstanten.AuflösenKonstante                     => Sf.Window.Keyboard.sfKeyDelete,
                                                                SystemKonstanten.PlündernKonstante                     => Sf.Window.Keyboard.sfKeyJ,
                                                                SystemKonstanten.HeimatstadtÄndernKonstante            => Sf.Window.Keyboard.sfKeyNum5,
                                                                SystemKonstanten.EinheitVerbessernKonstante            => Sf.Window.Keyboard.sfKeyTab,
                                                                SystemKonstanten.InfosKonstante                        => Sf.Window.Keyboard.sfKeyI,

                                                                SystemKonstanten.DiplomatieKonstante                   => Sf.Window.Keyboard.sfKeyTilde,

                                                                SystemKonstanten.GeheZuKonstante                       => Sf.Window.Keyboard.sfKeyG,

                                                                SystemKonstanten.StadtUmbenennenKonstante              => Sf.Window.Keyboard.sfKeyN,
                                                                SystemKonstanten.StadtAbreißenKonstante                => Sf.Window.Keyboard.sfKeyK,
                                                                SystemKonstanten.StadtSuchenKonstante                  => Sf.Window.Keyboard.sfKeyY,

                                                                SystemKonstanten.RundeBeendenTastenbelegungKonstante   => Sf.Window.Keyboard.sfKeyR,
                                                                SystemKonstanten.DebugmenüKonstante                    => Sf.Window.Keyboard.sfKeyC
                                                               ),

                                                             2 =>
                                                               (
                                                                SystemKonstanten.ObenKonstante                         => Sf.Window.Keyboard.sfKeyNum8,
                                                                SystemKonstanten.LinksKonstante                        => Sf.Window.Keyboard.sfKeyNum4,
                                                                SystemKonstanten.UntenKonstante                        => Sf.Window.Keyboard.sfKeyNum2,
                                                                SystemKonstanten.RechtsKonstante                       => Sf.Window.Keyboard.sfKeyNum6,
                                                                SystemKonstanten.LinksObenKonstante                    => Sf.Window.Keyboard.sfKeyNum7,
                                                                SystemKonstanten.RechtsObenKonstante                   => Sf.Window.Keyboard.sfKeyNum9,
                                                                SystemKonstanten.LinksUntenKonstante                   => Sf.Window.Keyboard.sfKeyNum1,
                                                                SystemKonstanten.RechtsUntenKonstante                  => Sf.Window.Keyboard.sfKeyNum3,
                                                                SystemKonstanten.EbeneHochKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.EbeneRunterKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemKonstanten.AuswählenKonstante                    => Sf.Window.Keyboard.sfKeyEnter,
                                                                SystemKonstanten.MenüZurückKonstante                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.BauenKonstante                        => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.ForschungKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.TechBaumKonstante                     => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemKonstanten.NächsteStadtKonstante                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.EinheitMitBewegungspunkteKonstante    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.AlleEinheitenKonstante                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.EinheitenOhneBewegungspunkteKonstante => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.NächsteStadtMeldungKonstante          => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.NächsteEinheitMeldungKonstante        => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemKonstanten.StraßeBauenKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.MineBauenKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.FarmBauenKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.FestungBauenKonstante                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.WaldAufforstenKonstante               => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.RodenTrockenlegenKonstante            => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.HeilenKonstante                       => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.VerschanzenKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.RundeAussetzenKonstante               => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.AuflösenKonstante                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.PlündernKonstante                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.HeimatstadtÄndernKonstante            => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.EinheitVerbessernKonstante            => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.InfosKonstante                        => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemKonstanten.DiplomatieKonstante                   => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemKonstanten.GeheZuKonstante                       => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemKonstanten.StadtUmbenennenKonstante              => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.StadtAbreißenKonstante                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.StadtSuchenKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,

                                                                SystemKonstanten.RundeBeendenTastenbelegungKonstante   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                SystemKonstanten.DebugmenüKonstante                    => Sf.Window.Keyboard.sfKeyUnknown
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
