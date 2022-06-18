pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Eingabe;

package body SpeichernLadenAllgemein is

   function SpielstandNameErmitteln
     return SystemRecords.TextEingabeRecord
   is begin
     
      SpielstandName := Eingabe.SpielstandName;
      
      if
        To_Wide_Wide_String (Source => SpielstandName.EingegebenerText)'Last > MaximaleZeichenlängeDateisystem
      then
         SpielstandName.EingegebenerText := To_Unbounded_Wide_Wide_String (Source => To_Wide_Wide_String (Source => SpielstandName.EingegebenerText) (1 .. MaximaleZeichenlängeDateisystem));
         
      else
         null;
      end if;
      
      return SpielstandName;
      
   end SpielstandNameErmitteln;
   
   
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return Boolean
   is begin
      
      return Exists (Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandnameExtern)));
      
   end SpielstandVorhanden;

end SpeichernLadenAllgemein;
