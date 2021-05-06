pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories, Ada.Streams.Stream_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories;

with GlobaleVariablen;

package Einlesen is

   function Einlesen
     return Boolean;

private

   Erfolgreich : Boolean;

   LeereZeilenAbzieher : Natural;
   SchleifenAbzug : Natural;
   Wert : Integer;

   ZwischenSpeicher : Unbounded_Wide_Wide_String;

   type WelcheTexteEinlesenNeuArray is array (GlobaleVariablen.TexteEinlesenNeuArray'Range (1)) of Unbounded_Wide_Wide_String;
   WelcheTexteEinlesenNeu : WelcheTexteEinlesenNeuArray;

   DateiNeuWelcheTexteEinlesen : File_Type;
   DateiNeuText : File_Type;

   type WelcheWerteEinlesenNeuArray is array (1 .. 5) of Unbounded_Wide_Wide_String;
   WelcheWerteEinlesenNeu : WelcheWerteEinlesenNeuArray;

   DateiNeuWelcheWerteEinlesen : File_Type;
   DateiNeuWerte : File_Type;

   Suche : Search_Type;
   Verzeichnis : Directory_Entry_Type;

   TastenbelegungLaden : Ada.Streams.Stream_IO.File_Type;

   procedure EinlesenWerte;

   procedure SprachenSortieren;

   procedure EinlesenTastaturbelegung;

   function EinlesenSprache
     return Boolean;

   function EinlesenTextNeu
     return Boolean;

end Einlesen;
