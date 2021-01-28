with Ada.Wide_Wide_Text_IO, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;

with Karten, GlobaleVariablen, Eingabe, Auswahl, Ladezeiten, GlobaleDatentypen;
use GlobaleDatentypen;

package Speichern is

   procedure Speichern (AutoSpeichern : Boolean);
   procedure SpeichernNeu (Autospeichern : Boolean);
   procedure AutoSpeichern;

private

   Zeilenanzahl : Integer;
   AutospeichernWert : Integer := 1;
   Wahl : Integer;

   KartenPlusWert : GlobaleDatentypen.Kartenfeld;

   SpielstandName : Unbounded_Wide_Wide_String;

   Datei : File_Type;

end Speichern;
