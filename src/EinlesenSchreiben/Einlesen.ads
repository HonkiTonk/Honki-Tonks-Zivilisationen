pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories, Ada.Streams.Stream_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Directories;

with GlobaleVariablen;

package Einlesen with
Abstract_State => (EinlesenState)
is

   function Einlesen
     return Boolean;

private

   Erfolgreich : Boolean with Part_Of => EinlesenState;

   LeereZeilenAbzieher : Natural with Part_Of => EinlesenState;
   SchleifenAbzug : Natural with Part_Of => EinlesenState;
   Wert : Integer with Part_Of => EinlesenState;

   ZwischenSpeicher : Unbounded_Wide_Wide_String with Part_Of => EinlesenState;

   type WelcheTexteEinlesenNeuArray is array (GlobaleVariablen.TexteEinlesenNeuArray'Range (1)) of Unbounded_Wide_Wide_String;
   WelcheTexteEinlesenNeu : WelcheTexteEinlesenNeuArray with Part_Of => EinlesenState;

   DateiNeuWelcheTexteEinlesen : File_Type with Part_Of => EinlesenState;
   DateiNeuText : File_Type with Part_Of => EinlesenState;

   type WelcheWerteEinlesenNeuArray is array (1 .. 5) of Unbounded_Wide_Wide_String;
   WelcheWerteEinlesenNeu : WelcheWerteEinlesenNeuArray with Part_Of => EinlesenState;

   DateiNeuWelcheWerteEinlesen : File_Type with Part_Of => EinlesenState;
   DateiNeuWerte : File_Type with Part_Of => EinlesenState;

   Suche : Search_Type with Part_Of => EinlesenState;
   Verzeichnis : Directory_Entry_Type with Part_Of => EinlesenState;

   TastenbelegungLaden : Ada.Streams.Stream_IO.File_Type with Part_Of => EinlesenState;

   procedure EinlesenWerte;

   procedure SprachenSortieren;

   procedure EinlesenTastaturbelegung;

   function EinlesenSprache
     return Boolean;

   function EinlesenTextNeu
     return Boolean;

end Einlesen;
