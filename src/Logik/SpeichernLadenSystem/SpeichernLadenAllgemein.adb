pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Eingabe;

package body SpeichernLadenAllgemein is

   function SpielstandNameErmitteln
     return Boolean
   is begin
     
      SpielstandName := Eingabe.SpielstandName;
      
      case
        SpielstandName.ErfolgreichAbbruch
      is
         when False =>
            return False;
            
         when True =>
            return Exists (Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName.EingegebenerText)));
      end case;
      
   end SpielstandNameErmitteln;

end SpeichernLadenAllgemein;
