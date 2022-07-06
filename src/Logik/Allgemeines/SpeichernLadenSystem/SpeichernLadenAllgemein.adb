pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Eingabe;
with InteraktionGrafiktask;

package body SpeichernLadenAllgemein is

   function SpielstandNameErmitteln
     return SystemRecords.TextEingabeRecord
   is begin
     
      InteraktionGrafiktask.NameSpielstand := True;
      SpielstandName := Eingabe.SpielstandName;
      InteraktionGrafiktask.NameSpielstand := False;
      
      -- Es wird hier keine Prüfung benötigt ob die Namenslänge > 0 ist, da dies schon in EingabeSFML.SpielstandName geprüft wird.
      return SpielstandName;
            
   end SpielstandNameErmitteln;
   
   
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return Boolean
   is begin
      
      return Exists (Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandnameExtern)));
      
   end SpielstandVorhanden;

end SpeichernLadenAllgemein;
