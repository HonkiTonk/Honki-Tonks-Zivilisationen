pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;

with Eingabe;

package body SpeichernLadenAllgemein is

   function SpielstandNameErmitteln
     return Boolean
   is begin
      
      SpielstandName := Eingabe.SpielstandName;

      return Exists (Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));
      
   end SpielstandNameErmitteln;

end SpeichernLadenAllgemein;
