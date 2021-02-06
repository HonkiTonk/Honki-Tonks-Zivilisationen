pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories;

with GlobaleVariablen;

package Einlesen is

   function Einlesen return Boolean;

private

   Erfolgreich : Boolean;

   Wert : Integer;

   type WelcheTexteEinlesenNeuArray is array (1 .. GlobaleVariablen.TexteEinlesenNeu'Last (1)) of Unbounded_Wide_Wide_String;
   WelcheTexteEinlesenNeu : WelcheTexteEinlesenNeuArray;

   DateiNeuWelcheTexteEinlesen : File_Type;
   DateiNeuText : File_Type;

   type WelcheWerteEinlesenNeuArray is array (1 .. 5) of Unbounded_Wide_Wide_String;
   WelcheWerteEinlesenNeu : WelcheWerteEinlesenNeuArray;

   DateiNeuWelcheWerteEinlesen : File_Type;
   DateiNeuWerte : File_Type;

   Suche : Search_Type;
   Verzeichnis : Directory_Entry_Type;

   procedure EinlesenWerte;

   function EinlesenSprache return Boolean;
   function EinlesenTextNeu return Boolean;

end Einlesen;
