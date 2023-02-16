private with Sf.Window.Keyboard;

with ZahlenDatentypen;
with SystemRecords;
with Meldungstexte;

package ZahleneingabeLogik is
   pragma Elaborate_Body;

   function Zahleneingabe
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger;
      WelcheFrageExtern : in Positive)
      return SystemRecords.ZahlenEingabeRecord
     with
       Pre => (
                 ZahlenMinimumExtern <= ZahlenMaximumExtern
               and
                 WelcheFrageExtern <= Meldungstexte.Frage'Last
              );

private

   WelchesVorzeichen : Boolean;
   LeerWert : Boolean;

   AktuelleZahl : Positive;
   StringNachZahl : Natural;

   ZahlenStringLeer : constant Wide_Wide_String (1 .. 10) := "0000000000";
   ZahlenString : Wide_Wide_String (1 .. 10);

   Zahlen : Sf.Window.Keyboard.sfKeyCode;
   Zwischenspeicher : Sf.Window.Keyboard.sfKeyCode;

   EingegebeneZahl : SystemRecords.ZahlenEingabeRecord;

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

   procedure ZahlHinzufügen
     (EingegebeneZahlExtern : in Sf.Window.Keyboard.sfKeyCode;
      ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
     with
       Pre => (
                 ZahlenMinimumExtern <= ZahlenMaximumExtern
              );

   procedure ZahlBeschränken
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
     with
       Pre => (
                 ZahlenMinimumExtern <= ZahlenMaximumExtern
              );

   procedure ZahlEntfernen;



   function MinimumMaximumSetzen
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
      return Boolean
     with
       Pre => (
                 ZahlenMinimumExtern <= ZahlenMaximumExtern
              );

   function ZahlSchleife
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
      return SystemRecords.ZahlenEingabeRecord
     with
       Pre => (
                 ZahlenMinimumExtern <= ZahlenMaximumExtern
              );

   function GanzeZahlPrüfung
     (ZeichenExtern : in Sf.Window.Keyboard.sfKeyCode)
      return Zahl_Prüfung_Enum;

   function VorzeichenAnpassen
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger;
      PlusMinusExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 ZahlenMinimumExtern <= ZahlenMaximumExtern
              );

   function ZahlenstringLimitieren
     (ZahlExtern : in ZahlenDatentypen.EigenerInteger)
      return Boolean;

end ZahleneingabeLogik;
