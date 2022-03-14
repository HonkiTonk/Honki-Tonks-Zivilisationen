pragma SPARK_Mode (On);

with Sf.Window.Keyboard;

with SystemDatentypen;
with SystemRecords;
with TastenbelegungDatentypen;
with TastenbelegungKonstanten;

package EingabeSFML is
   
   WelchesVorzeichen : Boolean;
   
   Frage : Positive;
   
   AktuellerWert : Natural;
      
   type TastenbelegungArray is array (1 .. 2, TastenbelegungDatentypen.Tastenbelegung_Verwendet_Enum'Range) of Sf.Window.Keyboard.sfKeyCode;
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
     return TastenbelegungDatentypen.Tastenbelegung_Enum;
   
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
                                                                TastenbelegungKonstanten.ObenKonstante                         => Sf.Window.Keyboard.sfKeyW,
                                                                TastenbelegungKonstanten.LinksKonstante                        => Sf.Window.Keyboard.sfKeyA,
                                                                TastenbelegungKonstanten.UntenKonstante                        => Sf.Window.Keyboard.sfKeyS,
                                                                TastenbelegungKonstanten.RechtsKonstante                       => Sf.Window.Keyboard.sfKeyD,
                                                                TastenbelegungKonstanten.LinksObenKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.RechtsObenKonstante                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.LinksUntenKonstante                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.RechtsUntenKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.EbeneHochKonstante                    => Sf.Window.Keyboard.sfKeyAdd,
                                                                TastenbelegungKonstanten.EbeneRunterKonstante                  => Sf.Window.Keyboard.sfKeySubtract,

                                                                TastenbelegungKonstanten.AuswählenKonstante                    => Sf.Window.Keyboard.sfKeyE,
                                                                TastenbelegungKonstanten.MenüZurückKonstante                   => Sf.Window.Keyboard.sfKeyEscape,
                                                                TastenbelegungKonstanten.BauenKonstante                        => Sf.Window.Keyboard.sfKeyB,
                                                                TastenbelegungKonstanten.ForschungKonstante                    => Sf.Window.Keyboard.sfKeyT,
                                                                TastenbelegungKonstanten.TechBaumKonstante                     => Sf.Window.Keyboard.sfKeyX,

                                                                TastenbelegungKonstanten.NächsteStadtKonstante                 => Sf.Window.Keyboard.sfKeySlash,
                                                                TastenbelegungKonstanten.EinheitMitBewegungspunkteKonstante    => Sf.Window.Keyboard.sfKeyPeriod,
                                                                TastenbelegungKonstanten.AlleEinheitenKonstante                => Sf.Window.Keyboard.sfKeyMultiply,
                                                                TastenbelegungKonstanten.EinheitenOhneBewegungspunkteKonstante => Sf.Window.Keyboard.sfKeyComma,
                                                                TastenbelegungKonstanten.NächsteStadtMeldungKonstante          => Sf.Window.Keyboard.sfKeyNum0,
                                                                TastenbelegungKonstanten.NächsteEinheitMeldungKonstante        => Sf.Window.Keyboard.sfKeyO,

                                                                TastenbelegungKonstanten.StraßeBauenKonstante                  => Sf.Window.Keyboard.sfKeyL,
                                                                TastenbelegungKonstanten.MineBauenKonstante                    => Sf.Window.Keyboard.sfKeyM,
                                                                TastenbelegungKonstanten.FarmBauenKonstante                    => Sf.Window.Keyboard.sfKeyF,
                                                                TastenbelegungKonstanten.FestungBauenKonstante                 => Sf.Window.Keyboard.sfKeyU,
                                                                TastenbelegungKonstanten.WaldAufforstenKonstante               => Sf.Window.Keyboard.sfKeyZ,
                                                                TastenbelegungKonstanten.RodenTrockenlegenKonstante            => Sf.Window.Keyboard.sfKeyP,
                                                                TastenbelegungKonstanten.HeilenKonstante                       => Sf.Window.Keyboard.sfKeyH,
                                                                TastenbelegungKonstanten.VerschanzenKonstante                  => Sf.Window.Keyboard.sfKeyV,
                                                                TastenbelegungKonstanten.RundeAussetzenKonstante               => Sf.Window.Keyboard.sfKeySpace,
                                                                TastenbelegungKonstanten.AuflösenKonstante                     => Sf.Window.Keyboard.sfKeyDelete,
                                                                TastenbelegungKonstanten.PlündernKonstante                     => Sf.Window.Keyboard.sfKeyJ,
                                                                TastenbelegungKonstanten.HeimatstadtÄndernKonstante            => Sf.Window.Keyboard.sfKeyNum5,
                                                                TastenbelegungKonstanten.EinheitVerbessernKonstante            => Sf.Window.Keyboard.sfKeyTab,
                                                                TastenbelegungKonstanten.InfosKonstante                        => Sf.Window.Keyboard.sfKeyI,

                                                                TastenbelegungKonstanten.DiplomatieKonstante                   => Sf.Window.Keyboard.sfKeyTilde,

                                                                TastenbelegungKonstanten.GeheZuKonstante                       => Sf.Window.Keyboard.sfKeyG,

                                                                TastenbelegungKonstanten.StadtUmbenennenKonstante              => Sf.Window.Keyboard.sfKeyN,
                                                                TastenbelegungKonstanten.StadtAbreißenKonstante                => Sf.Window.Keyboard.sfKeyK,
                                                                TastenbelegungKonstanten.StadtSuchenKonstante                  => Sf.Window.Keyboard.sfKeyY,

                                                                TastenbelegungKonstanten.RundeBeendenTastenbelegungKonstante   => Sf.Window.Keyboard.sfKeyR,
                                                                TastenbelegungKonstanten.DebugmenüKonstante                    => Sf.Window.Keyboard.sfKeyC
                                                               ),

                                                             2 =>
                                                               (
                                                                TastenbelegungKonstanten.ObenKonstante                         => Sf.Window.Keyboard.sfKeyNum8,
                                                                TastenbelegungKonstanten.LinksKonstante                        => Sf.Window.Keyboard.sfKeyNum4,
                                                                TastenbelegungKonstanten.UntenKonstante                        => Sf.Window.Keyboard.sfKeyNum2,
                                                                TastenbelegungKonstanten.RechtsKonstante                       => Sf.Window.Keyboard.sfKeyNum6,
                                                                TastenbelegungKonstanten.LinksObenKonstante                    => Sf.Window.Keyboard.sfKeyNum7,
                                                                TastenbelegungKonstanten.RechtsObenKonstante                   => Sf.Window.Keyboard.sfKeyNum9,
                                                                TastenbelegungKonstanten.LinksUntenKonstante                   => Sf.Window.Keyboard.sfKeyNum1,
                                                                TastenbelegungKonstanten.RechtsUntenKonstante                  => Sf.Window.Keyboard.sfKeyNum3,
                                                                TastenbelegungKonstanten.EbeneHochKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.EbeneRunterKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungKonstanten.AuswählenKonstante                    => Sf.Window.Keyboard.sfKeyEnter,
                                                                TastenbelegungKonstanten.MenüZurückKonstante                   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.BauenKonstante                        => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.ForschungKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.TechBaumKonstante                     => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungKonstanten.NächsteStadtKonstante                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.EinheitMitBewegungspunkteKonstante    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.AlleEinheitenKonstante                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.EinheitenOhneBewegungspunkteKonstante => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.NächsteStadtMeldungKonstante          => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.NächsteEinheitMeldungKonstante        => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungKonstanten.StraßeBauenKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.MineBauenKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.FarmBauenKonstante                    => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.FestungBauenKonstante                 => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.WaldAufforstenKonstante               => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.RodenTrockenlegenKonstante            => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.HeilenKonstante                       => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.VerschanzenKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.RundeAussetzenKonstante               => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.AuflösenKonstante                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.PlündernKonstante                     => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.HeimatstadtÄndernKonstante            => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.EinheitVerbessernKonstante            => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.InfosKonstante                        => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungKonstanten.DiplomatieKonstante                   => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungKonstanten.GeheZuKonstante                       => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungKonstanten.StadtUmbenennenKonstante              => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.StadtAbreißenKonstante                => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.StadtSuchenKonstante                  => Sf.Window.Keyboard.sfKeyUnknown,

                                                                TastenbelegungKonstanten.RundeBeendenTastenbelegungKonstante   => Sf.Window.Keyboard.sfKeyUnknown,
                                                                TastenbelegungKonstanten.DebugmenüKonstante                    => Sf.Window.Keyboard.sfKeyUnknown
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
