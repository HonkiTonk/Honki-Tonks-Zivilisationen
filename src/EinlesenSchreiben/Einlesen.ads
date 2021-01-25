with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories, Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Characters.Conversions;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories, Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar;

with GlobaleVariablen, KartenDatenbank, VerbesserungenDatenbank, GebaeudeDatenbank, ForschungsDatenbank, EinheitenDatenbank, Ladezeiten, Auswahl, Schreiben;

package Einlesen is

   function Einlesen return Boolean;

private

   Erfolgreich : Boolean;

   Wert : Integer;

   type WelcheTexteEinlesenNeuArray is array (1 .. GlobaleVariablen.TexteEinlesenNeu'Last (1)) of Unbounded_Wide_Wide_String;
   WelcheTexteEinlesenNeu : WelcheTexteEinlesenNeuArray;

   DateiNeuWelcheTexteEinlesen : Ada.Wide_Wide_Text_IO.File_Type;
   DateiNeuText : Ada.Wide_Wide_Text_IO.File_Type;


   type WelcheWerteEinlesenNeuArray is array (1 .. 5) of Unbounded_Wide_Wide_String;
   WelcheWerteEinlesenNeu : WelcheWerteEinlesenNeuArray;

   DateiNeuWelcheWerteEinlesen : Ada.Wide_Wide_Text_IO.File_Type;
   DateiNeuWerte : Ada.Wide_Wide_Text_IO.File_Type;



   Suche : Search_Type;
   Verzeichnis : Directory_Entry_Type;

   procedure EinlesenWerte;

   function EinlesenSprache return Boolean;
   function EinlesenTextNeu return Boolean;

end Einlesen;
