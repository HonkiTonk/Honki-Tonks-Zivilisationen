pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with ZahlenDatentypen;
with SystemRecords;
with TastenbelegungDatentypen;
with StadtRecords;

package EingabeLogik is
   
   WelchesVorzeichen : Boolean;
      
   AktuellerWert : Natural;
   
   

   -- Das hier mal überarbeiten! äöü
   function GanzeZahl
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger;
      WelcheFrageExtern : in Positive)
      return SystemRecords.ZahlenEingabeRecord
     with
       Pre => (
                 ZahlenMinimumExtern <= ZahlenMaximumExtern
              );
   
   function StadtName
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return SystemRecords.TextEingabeRecord
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

   function SpielstandName
     return SystemRecords.TextEingabeRecord;

   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum;
   
   function TastenbelegungAnpassen
     return Sf.Window.Keyboard.sfKeyCode;
   
private
   
   AktuelleZahl : Positive;
   
   ZahlenStringLeer : constant Wide_Wide_String (1 .. 10) := "0000000000";
   ZahlenString : Wide_Wide_String (1 .. 10);
      
   Zahlen : Sf.Window.Keyboard.sfKeyCode;
   Taste : Sf.Window.Keyboard.sfKeyCode;
   Zwischenspeicher : Sf.Window.Keyboard.sfKeyCode;
   
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
      
   procedure VorzeichenAnpassen
     (ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger;
      PlusMinusExtern : in Boolean)
     with
       Pre => (
                 ZahlenMinimumExtern <= ZahlenMaximumExtern
              );

   procedure ZahlHinzufügen
     (EingegebeneZahlExtern : in Sf.Window.Keyboard.sfKeyCode);

   procedure ZahlEntfernen;
   procedure EingabeAbwarten;
   
      
   
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
      return Boolean
     with
       Pre => (
                 ZahlenMinimumExtern <= ZahlenMaximumExtern
              );
   
   function GanzeZahlPrüfung
     (ZeichenExtern : in Sf.Window.Keyboard.sfKeyCode)
      return Zahl_Prüfung_Enum;
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return SystemRecords.TextEingabeRecord;

end EingabeLogik;